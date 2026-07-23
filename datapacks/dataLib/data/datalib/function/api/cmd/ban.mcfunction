execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0

execute unless entity @s[gamemode=creative,tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

# ─────────────────────────────────────────────────────────────────
# GATE REQUEST — Dangerous commands require admin confirmation
# ─────────────────────────────────────────────────────────────────
$data modify storage datalib:engine pending_gate set value {type:"ban", player:"$(player)", reason:"$(reason)"}
function dl_load:gate/request
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ban request ","color":"aqua"},{"text":"$(player) $(reason)","color":"white"}]
