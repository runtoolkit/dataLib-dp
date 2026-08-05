$scoreboard players set $sign_v dl.tmp $(value)
execute if score $sign_v dl.tmp matches 1.. run data modify storage datalib:output result set value 1
execute if score $sign_v dl.tmp matches 0 run data modify storage datalib:output result set value 0
execute if score $sign_v dl.tmp matches ..-1 run data modify storage datalib:output result set value -1
