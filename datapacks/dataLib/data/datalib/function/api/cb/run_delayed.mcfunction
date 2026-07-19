# datalib:api/cb/run_delayed
# ─────────────────────────────────────────────────────────────────
# Schedules a command string to execute via command block after a delay.
#
# INPUT  (storage datalib:input cb):
#   cmd     (string)  — the command to run    [REQUIRED]
#   delay   (int)     — delay in ticks        [REQUIRED, min 1]
#   x       (int)     — CB block X            [default: 0]
#   y       (int)     — CB block Y            [default: -64]
#   z       (int)     — CB block Z            [default: 0]
#
# SECURITY: caller must hold dl.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   data modify storage datalib:input cb set value {cmd:"say delayed!",delay:40}
#   function datalib:api/cb/run_delayed
# ─────────────────────────────────────────────────────────────────

# Security gate
execute unless function datalib:core/security/cmd_gate run return 0

# Verify required inputs
execute unless data storage datalib:input cb.cmd run tellraw @s [{"text":"[DL/cb] ","color":"#00AAAA","bold":true},{"text":"cb.cmd not set","color":"red"}]
execute unless data storage datalib:input cb.cmd run return 0
execute unless data storage datalib:input cb.delay run tellraw @s [{"text":"[DL/cb] ","color":"#00AAAA","bold":true},{"text":"cb.delay not set","color":"red"}]
execute unless data storage datalib:input cb.delay run return 0

# Fill coordinate defaults
function datalib:core/internal/api/cb/apply_defaults

# Push to delay queue and schedule flush
function datalib:core/internal/systems/cb/queue_push with storage datalib:input cb
data remove storage datalib:input cb
