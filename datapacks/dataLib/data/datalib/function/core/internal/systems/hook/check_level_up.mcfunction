execute store result score $hlvl_cur dl.tmp run data get entity @s XpLevel
execute if score @s datalib.hook_lvl < $hlvl_cur dl.tmp run scoreboard players operation @s datalib.hook_lvl_new = $hlvl_cur dl.tmp
execute if score @s datalib.hook_lvl < $hlvl_cur dl.tmp run function datalib:core/internal/systems/hook/on_level_up
execute store result score @s datalib.hook_lvl run scoreboard players get $hlvl_cur dl.tmp
