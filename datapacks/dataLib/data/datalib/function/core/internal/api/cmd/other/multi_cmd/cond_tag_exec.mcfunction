# [MACRO] INPUT: $(tag)
$execute unless entity @s[tag=$(tag)] run scoreboard players set $mcmd_cond_result dl.tmp 0
