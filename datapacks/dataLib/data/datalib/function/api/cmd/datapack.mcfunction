execute unless function datalib:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless entity @s[tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

$execute if data storage datalib:input {action:"disable"} run datapack disable $(pack)
$execute if data storage datalib:input {action:"enable"} run datapack enable $(pack)
