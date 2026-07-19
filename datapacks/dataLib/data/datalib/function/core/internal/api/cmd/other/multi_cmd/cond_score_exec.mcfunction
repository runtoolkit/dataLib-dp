# [MACRO] INPUT: $(objective), $(min), $(max)
$execute store result score $mcmd_cond_score dl.tmp run scoreboard players get @s $(objective)
$execute if score $mcmd_cond_score dl.tmp matches $(min)..$(max) run return 0
scoreboard players set $mcmd_cond_result dl.tmp 0
