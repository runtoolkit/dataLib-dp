# ======================================================================================
# datalib:core/security/string/contains
# ======================================================================================
#
# PURPOSE:
#   Real substring/prefix test for input_check. Replaces the previous
#   `execute if data storage ... inputs{field:"literal"}` pattern, which is
#   NBT compound matching, not string matching — an NBT match against a
#   string key requires the stored value to be BYTE-FOR-BYTE IDENTICAL to
#   the pattern. It is not a "contains" or "starts with" test.
#
#   Consequence of the old code:
#     - Section 6 checked `unless ... inputs{func:"datalib:api/"}` expecting
#       this to mean "func does not start with datalib:api/". Since func is
#       always longer than the literal "datalib:api/" (e.g.
#       "datalib:api/cmd/freeze"), the two strings are NEVER equal, so the
#       `unless` condition is ALWAYS true — every legitimate call, without
#       exception, was rejected as a namespace violation.
#     - Every blocklist line (Sections 8-19) checked
#       `if ... inputs{cmd:"op "}` expecting "cmd contains/starts with op ".
#       Since real payloads are never byte-identical to the short literal
#       (e.g. cmd is "op @a FakeAdmin" not "op "), these checks NEVER
#       matched either — the entire blocklist was dead code that could
#       never fire, meaning every dangerous command in Sections 8-19 was
#       silently allowed straight through to execute_validated.
#
#   Net effect of the bug: fails open on danger (blocklist never triggers)
#   and fails closed on safety (allowlist rejects everything). This
#   function fixes both by doing real substring matching via StringLib.
#
# USAGE:
#   data modify storage datalib:input find.String set value "<haystack>"
#   data modify storage datalib:input find.Find set value "<needle>"
#   function datalib:core/security/string/contains
#   Return: 1 if Find occurs anywhere in String, 0 otherwise.
#   Output: score #DL.StrFound dl.tmp  → 1 (found) / 0 (not found)
#           score #DL.StrIndex dl.tmp  → index of first match, or -1
#
# NOTE ON PREFIX CHECKS:
#   To test "does String start with Find", call this function and then
#   separately check `#DL.StrIndex dl.tmp matches 0` (index 0 = prefix).
#   `contains` (index >= 0) is what Sections 8-19 need; prefix (index 0)
#   is what Section 6's allowlist needs.
#
# WHY find AND NOT to_lowercase/replace:
#   Only stringlib:zprivate/concat and stringlib:zprivate/find ship in this
#   pack — replace/to_lowercase/to_uppercase/split/insert reference
#   zprivate paths that do not exist here and will error if called
#   (see datalib:core/security/sanitize header comment for the same
#   finding). find + concat are the only verified-working primitives,
#   so all matching here is built on find alone.
#
# ISOLATION:
#   Uses stringlib:input/output find — the same storage StringLib itself
#   uses. Snapshot-restore is not needed for our purposes since dataLib's
#   own input_check already snapshots its own inputs into datalib:output
#   before this ever runs (Section 3), so a nested call here does not
#   corrupt datalib's caller-facing state, only stringlib's, which is
#   scratch space owned entirely by StringLib.
#
# ======================================================================================

# n:1 → first match only, minimal work. We only need "does it occur at all"
# and "at what index does the first occurrence start".
data modify storage stringlib:input find.n set value 1

function stringlib:util/find

# find returns [-1] (as a literal one-element list) when nothing is found,
# or [<index>] for the first match when n:1.
execute store result score #DL.StrIndex dl.tmp run data get storage stringlib:output find[0]

execute if score #DL.StrIndex dl.tmp matches -1 run scoreboard players set #DL.StrFound dl.tmp 0
execute unless score #DL.StrIndex dl.tmp matches -1 run scoreboard players set #DL.StrFound dl.tmp 1

# Cleanup stringlib scratch storage so repeated calls this tick don't leak
# stale state into the next comparison.
data remove storage stringlib:input find
data remove storage stringlib:output find

execute if score #DL.StrFound dl.tmp matches 1 run return 1
return 0
