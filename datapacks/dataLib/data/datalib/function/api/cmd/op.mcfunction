execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0

execute unless entity @s[gamemode=creative,tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Enable:  /data modify storage datalib:engine sandbox set value 1b
# Disable: /data modify storage datalib:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine {sandbox:1b} run data modify storage datalib:engine _sandbox_cmd set value "op"
execute if data storage datalib:engine {sandbox:1b} run execute unless function datalib:core/internal/api/cmd/sandbox_gate run return 0
execute unless data storage datalib:engine {sandbox:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"TIP ","color":"yellow","bold":true},{"text":"Sandbox mode recommended → ","color":"gray"},{"text":"/data modify storage datalib:engine sandbox set value 1b","color":"aqua"}]
$op $(player)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/op ","color":"aqua"},{"text":"$(player)","color":"white"}]
