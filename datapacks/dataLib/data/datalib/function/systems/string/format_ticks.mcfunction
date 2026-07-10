$scoreboard players set $ft_t dl.tmp $(ticks)

scoreboard players set $ft_20 dl.tmp 20
scoreboard players operation $ft_s dl.tmp = $ft_t dl.tmp
scoreboard players operation $ft_s dl.tmp /= $ft_20 dl.tmp

execute store result storage datalib:output total_seconds int 1 run scoreboard players get $ft_s dl.tmp

scoreboard players set $ft_60 dl.tmp 60
scoreboard players operation $ft_m dl.tmp = $ft_s dl.tmp
scoreboard players operation $ft_m dl.tmp /= $ft_60 dl.tmp

scoreboard players operation $ft_s dl.tmp %= $ft_60 dl.tmp

execute store result storage datalib:output minutes int 1 run scoreboard players get $ft_m dl.tmp
execute store result storage datalib:output seconds int 1 run scoreboard players get $ft_s dl.tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/format_ticks ","color":"aqua"},{"text":"$(ticks)t","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"minutes","color":"green"},{"text":"m ","color":"#555555"},{"storage":"datalib:output","nbt":"seconds","color":"green"},{"text":"s","color":"#555555"}]
