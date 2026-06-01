execute unless function datalib:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Active:  /data modify storage datalib:engine sandbox set value 1b
# Inactive:  /data modify storage datalib:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine {sandbox:1b} run data modify storage datalib:engine _sandbox_cmd set value "clear"
execute if data storage datalib:engine {sandbox:1b} run execute unless function datalib:core/internal/api/cmd/sandbox_gate run return 0
$execute as @a[name=$(player),limit=1] at @s run clear @s
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/clear ","color":"aqua"},{"text":"$(player)","color":"white"}]}
