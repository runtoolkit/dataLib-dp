# datalib:api/cb/run
# ─────────────────────────────────────────────────────────────────
# Executes a raw command string via a temporary command block.
# Zero-delay variant: fires next tick, cleaned up 2t later.
#
# INPUT  (storage datalib:input cb):
#   cmd   (string)  — the command to run  [REQUIRED]
#   x     (int)     — CB block X          [default: 0]
#   y     (int)     — CB block Y          [default: -64]
#   z     (int)     — CB block Z          [default: 0]
#
# SECURITY: caller must hold dl.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   data modify storage datalib:input cb set value {cmd:"say hello"}
#   function datalib:api/cb/run
# ─────────────────────────────────────────────────────────────────

# Security gate
execute unless function datalib:core/security/cmd_gate run return 0

# Verify required input
execute unless data storage datalib:input cb.cmd run tellraw @s [{"text":"[DL/cb] ","color":"#00AAAA","bold":true},{"text":"cb.cmd not set","color":"red"}]
execute unless data storage datalib:input cb.cmd run return 0

# Fill coordinate defaults
function datalib:core/internal/api/cb/apply_defaults

# Execute
function datalib:core/internal/api/cb/exec with storage datalib:input cb
data remove storage datalib:input cb
