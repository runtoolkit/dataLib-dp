$execute as @a[name=$(player),limit=1] at @s run summon $(entity) ~ ~ ~ $(nbt)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/summon_at_player ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(entity)","color":"aqua"}]
