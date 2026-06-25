# datalib:systems/dev_settings/display/open
# Clears any existing settings book then dispatches to the correct page function.
# Page functions give the book directly via item replace — no storage intermediate.

execute unless function datalib:debug/tools/utils/perm_check run return 0

# Reset cursor if out of range
execute unless score @s dl.dev_pg2 matches 1..2 run scoreboard players set @s dl.dev_pg2 1

# Clear existing book
clear @s minecraft:written_book[custom_data={datalib_dev_settings:1b}]

# Dispatch — each page function does its own item replace
execute as @s[scores={dl.dev_pg2=1}] run function datalib:systems/dev_settings/display/page/version
execute as @s[scores={dl.dev_pg2=2}] run function datalib:systems/dev_settings/display/page/devmode
