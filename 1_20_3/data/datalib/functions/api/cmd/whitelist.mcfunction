execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Active:  /data modify storage datalib:engine sandbox set value 1b
# Inactive:  /data modify storage datalib:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage datalib:engine {sandbox:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"SANDBOX — cmd/whitelist blocked.","color":"red"}]
execute if data storage datalib:engine {sandbox:1b} run return 0
execute unless data storage datalib:engine {sandbox:1b} run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"TIP ","color":"yellow","bold":true},{"text":"Sandbox mode recommended → ","color":"gray"},{"text":"/data modify storage datalib:engine sandbox set value 1b","color":"aqua"}]
$whitelist $(action) $(player)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/whitelist ","color":"aqua"},{"text":"$(action) $(player)","color":"white"}]}
