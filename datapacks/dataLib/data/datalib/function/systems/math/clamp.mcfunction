$scoreboard players set $clamp_v dl.tmp $(value)
$scoreboard players set $clamp_lo dl.tmp $(min)
$scoreboard players set $clamp_hi dl.tmp $(max)

execute if score $clamp_v dl.tmp < $clamp_lo dl.tmp run scoreboard players operation $clamp_v dl.tmp = $clamp_lo dl.tmp
execute if score $clamp_v dl.tmp > $clamp_hi dl.tmp run scoreboard players operation $clamp_v dl.tmp = $clamp_hi dl.tmp

execute store result storage datalib:output result int 1 run scoreboard players get $clamp_v dl.tmp
