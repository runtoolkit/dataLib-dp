execute unless function datalib:debug/tools/utils/check_all unless entity @s[tag=datalib.admin,scores={dl.perm_level=2..}] run return 0

$execute as @a[limit=1,name="(target)] at @a[name=$(target)] run function $(func) with storage datalib:input {}
