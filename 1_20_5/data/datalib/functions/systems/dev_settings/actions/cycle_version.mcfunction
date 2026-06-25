# datalib:systems/dev_settings/actions/cycle_version
# Cycles datalib:engine dev_settings.version through: 116 → 117 → 118 → 119 → 120 → 116
# Refreshes the book immediately after cycle.

execute unless function datalib:debug/tools/utils/perm_check run return 0

execute store result score #dl.dsv dl.tmp run data get storage datalib:engine dev_settings.version

execute if score #dl.dsv dl.tmp matches 116 run data modify storage datalib:engine dev_settings.version set value 117
execute if score #dl.dsv dl.tmp matches 117 run data modify storage datalib:engine dev_settings.version set value 118
execute if score #dl.dsv dl.tmp matches 118 run data modify storage datalib:engine dev_settings.version set value 119
execute if score #dl.dsv dl.tmp matches 119 run data modify storage datalib:engine dev_settings.version set value 120
execute if score #dl.dsv dl.tmp matches 120 run data modify storage datalib:engine dev_settings.version set value 116
# Fallback: reset to 120
execute unless score #dl.dsv dl.tmp matches 116..120 run data modify storage datalib:engine dev_settings.version set value 120

scoreboard players reset #dl.dsv dl.tmp

# Refresh book
function datalib:systems/dev_settings/display/open

tellraw @s ["",{"text":"[Dev Settings] ","color":"gold"},{"text":"Version updated.","color":"yellow"}]
