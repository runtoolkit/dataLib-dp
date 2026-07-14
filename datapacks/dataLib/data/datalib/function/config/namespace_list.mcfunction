# ======================================================================================
# datalib:config/namespace_list
# ======================================================================================
#
# PURPOSE:
#   Single source of truth for input_check Section 5 (namespace allowlist
#   enforcement). Each approved prefix is added here, one line, one prefix.
#   input_check calls this via `function` and reads the resulting list from
#   storage — no other file should hardcode an allowlist prefix.
#
# POLICY:
#   Every line added here is a widening of what external callers may invoke
#   through datalib's dynamic call interface. This is a security-relevant
#   change and MUST go through code review (PR), never a live/runtime edit
#   (no /data modify storage against this list from in-game).
#
# BEFORE ADDING A PREFIX, THE PR MUST ANSWER:
#   1. Does every function under this namespace, that could ever be reached
#      through datalib's dynamic call path, tolerate the same threat model
#      input_check enforces (selector abuse, execute-chain hijacking,
#      NBT/storage injection, gamerule/scoreboard abuse, entity/tag
#      manipulation, forceload/block abuse)? input_check's Sections 8-19
#      only pattern-match on `cmd` payload text — they do not know which
#      namespace originated the call, so a vulnerable function under a
#      newly-allowed namespace is NOT separately protected.
#   2. Is every function under this namespace fully authored/audited by
#      this project (not a third-party pack with unknown internals)?
#   3. What is the narrowest possible prefix? Prefer "stringlib:util/"
#      over "stringlib:" if only the util/ functions are meant to be
#      externally callable.
#
# FORMAT:
#   One prefix per line, appended to the list below. Do not remove the
#   "datalib:" line — it is the original, always-required baseline.
#
# CURRENT STATE:
#   No additional namespaces have been approved yet. Only datalib:
#   is allowed. This file exists so future additions are a single-line,
#   reviewable PR diff instead of an edit inside input_check.mcfunction
#   itself.
#
# ======================================================================================

data modify storage datalib:output config.namespace_allowlist set value ["datalib:","datalib.main:empty"]

# --- Approved additional prefixes go below this line, one per line. ---
# Example (DO NOT UNCOMMENT WITHOUT A REVIEWED PR):
# data modify storage datalib:output config.namespace_allowlist append value "stringlib:util/"
