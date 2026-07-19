# datalib:api/cb/run_sequence
# ─────────────────────────────────────────────────────────────────
# Schedules a list of commands to run sequentially, each separated
# by a configurable interval.
#
# INPUT  (storage datalib:input cb):
#   cmds      (list of strings) — commands to run  [REQUIRED, min 1]
#   interval  (int)             — ticks between each command  [default: 2]
#   x         (int)             — CB block X  [default: 0]
#   y         (int)             — CB block Y  [default: -64]
#   z         (int)             — CB block Z  [default: 0]
#
# SECURITY: caller must hold dl.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   data modify storage datalib:input cb set value {cmds:["say one","say two","say three"],interval:20}
#   function datalib:api/cb/run_sequence
# ─────────────────────────────────────────────────────────────────

# Security gate
execute unless function datalib:core/security/cmd_gate run return 0

# Verify required input
execute unless data storage datalib:input cb.cmds[0] run tellraw @s [{"text":"[DL/cb] ","color":"#00AAAA","bold":true},{"text":"cb.cmds is empty or not set","color":"red"}]
execute unless data storage datalib:input cb.cmds[0] run return 0

# Fill defaults
function datalib:core/internal/api/cb/apply_defaults
execute unless data storage datalib:input cb.interval run data modify storage datalib:input cb.interval set value 2

# Expand cmds list into individual delayed queue entries
function datalib:core/internal/systems/cb/seq_expand
data remove storage datalib:input cb
