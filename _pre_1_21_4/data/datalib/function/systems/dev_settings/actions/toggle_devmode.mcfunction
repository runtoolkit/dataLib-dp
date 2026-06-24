# datalib:systems/dev_settings/actions/toggle_devmode
# Toggles datalib:engine dev_settings.devMode between 0b and 1b.
# Refreshes the book immediately after toggle.

execute unless function datalib:debug/tools/utils/perm_check run return 0

execute store result score #dl.dsm dl.tmp run data get storage datalib:engine dev_settings.devMode

execute if score #dl.dsm dl.tmp matches 1 run data modify storage datalib:engine dev_settings.devMode set value 0b
execute unless score #dl.dsm dl.tmp matches 1 run data modify storage datalib:engine dev_settings.devMode set value 1b

scoreboard players reset #dl.dsm dl.tmp

# Refresh book
function datalib:systems/dev_settings/display/open

tellraw @s ["",{"text":"[Dev Settings] ","color":"gold"},{"text":"devMode updated.","color":"yellow"}]
