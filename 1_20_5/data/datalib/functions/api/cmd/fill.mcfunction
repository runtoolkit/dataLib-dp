execute unless function datalib:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Active:  /data modify storage datalib:engine sandbox set value 1b
# Inactive:  /data modify storage datalib:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine {sandbox:1b} run data modify storage datalib:engine _sandbox_cmd set value "fill"
execute if data storage datalib:engine {sandbox:1b} run execute unless function datalib:core/internal/api/cmd/sandbox_gate run return 0
$fill $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(block) $(mode)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/fill ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(mode)","color":"aqua"}]}
