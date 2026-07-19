# datalib:api/gamerule/set [MACRO]
# Sets a custom gamerule value, persists it in storage, and dispatches
# a callback function when the value matches a defined condition.
#
# INPUT (macro args via `with storage datalib:input {}`):
#   $(rule)      — rule name string, e.g. "pvp_enabled"
#   $(value)     — value string: "true", "false", or a number string e.g. "10"
#
# OPTIONAL storage keys (set before calling, removed after):
#   datalib:input gr_on_true   — function to call when value is "true"
#   datalib:input gr_on_false  — function to call when value is "false"
#   datalib:input gr_on_value  — function to call for any numeric match
#   datalib:input gr_matches   — scoreboard range string, e.g. "5..10" (used with gr_on_value)
#
# EXAMPLE:
#   data modify storage datalib:input rule set value "pvp_enabled"
#   data modify storage datalib:input value set value "true"
#   data modify storage datalib:input gr_on_true set value "mypack:pvp/enable"
#   data modify storage datalib:input gr_on_false set value "mypack:pvp/disable"
#   function datalib:api/gamerule/set with storage datalib:input {}
#
# RETURN: 1 on success, 0 on guard failure.

execute unless function datalib:core/security/cmd_gate run return 0

# ── Normalize rule name: spaces → underscores via StringLib ──────────────────
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace

# ── Persist value in engine storage ──────────────────────────────────────────
function datalib:core/internal/api/gamerule/persist with storage datalib:input {}

# ── Dispatch callbacks ────────────────────────────────────────────────────────
function datalib:core/internal/api/gamerule/dispatch with storage datalib:input {}

# ── Debug log ─────────────────────────────────────────────────────────────────
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/set ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"text":"$(value)","color":"green"}]

# ── Cleanup ───────────────────────────────────────────────────────────────────
data remove storage datalib:input _gamerule_norm

return 1
