# type:"cmd" → {cmd:"say hello"}
# Security: only executors with the datalib.admin tag may run this.
execute unless entity @s[tag=datalib.admin] run return 0
tellraw @a[tag=datalib.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
