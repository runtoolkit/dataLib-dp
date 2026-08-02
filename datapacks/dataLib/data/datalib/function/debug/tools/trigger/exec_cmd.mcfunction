# type:"cmd" → {cmd:"say hello"}
# Security: only executors with the datalib.admin tag may run this.
execute unless entity @s[tag=datalib.admin] run return 0
$execute as @a[nbt=$(uuid)] at @s run $(cmd)
