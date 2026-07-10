# datalib:systems/math/vec/internal/arccos_lookup
# $vang_dot dl.tmp = cos×1000 value ([-1000, 1000])
# 10° resolution arccos lookup table.

execute if score $vang_dot dl.tmp matches 993.. run data modify storage datalib:output result set value 0
execute if score $vang_dot dl.tmp matches 963..992 run data modify storage datalib:output result set value 10
execute if score $vang_dot dl.tmp matches 903..962 run data modify storage datalib:output result set value 20
execute if score $vang_dot dl.tmp matches 816..902 run data modify storage datalib:output result set value 30
execute if score $vang_dot dl.tmp matches 705..815 run data modify storage datalib:output result set value 40
execute if score $vang_dot dl.tmp matches 571..704 run data modify storage datalib:output result set value 50
execute if score $vang_dot dl.tmp matches 421..570 run data modify storage datalib:output result set value 60
execute if score $vang_dot dl.tmp matches 258..420 run data modify storage datalib:output result set value 70
execute if score $vang_dot dl.tmp matches 87..257 run data modify storage datalib:output result set value 80
execute if score $vang_dot dl.tmp matches -87..86 run data modify storage datalib:output result set value 90
execute if score $vang_dot dl.tmp matches -257..-88 run data modify storage datalib:output result set value 100
execute if score $vang_dot dl.tmp matches -420..-258 run data modify storage datalib:output result set value 110
execute if score $vang_dot dl.tmp matches -570..-421 run data modify storage datalib:output result set value 120
execute if score $vang_dot dl.tmp matches -704..-571 run data modify storage datalib:output result set value 130
execute if score $vang_dot dl.tmp matches -815..-705 run data modify storage datalib:output result set value 140
execute if score $vang_dot dl.tmp matches -902..-816 run data modify storage datalib:output result set value 150
execute if score $vang_dot dl.tmp matches -962..-903 run data modify storage datalib:output result set value 160
execute if score $vang_dot dl.tmp matches -992..-963 run data modify storage datalib:output result set value 170
execute if score $vang_dot dl.tmp matches ..-993 run data modify storage datalib:output result set value 180

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/vec/angle_between ","color":"aqua"},{"text":"cos×1000=","color":"gray"},{"score":{"name":"$vang_dot","objective":"dl.tmp"},"color":"yellow"},{"text":" → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"yellow"},{"text":"°","color":"gray"}]
