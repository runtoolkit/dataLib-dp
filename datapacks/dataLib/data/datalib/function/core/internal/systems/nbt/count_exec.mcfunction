# datalib:systems/nbt/internal/count_exec [MACRO]
# INPUT: $(storage), $(path)

scoreboard players set $nbt_count dl.tmp 0
$execute store result score $nbt_count dl.tmp run data get storage $(storage) $(path)

execute store result storage datalib:output result int 1 run scoreboard players get $nbt_count dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"nbt/count ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"},{"text":" → ","color":"#555555"},{"score":{"name":"$nbt_count","objective":"dl.tmp"},"color":"green"}]
