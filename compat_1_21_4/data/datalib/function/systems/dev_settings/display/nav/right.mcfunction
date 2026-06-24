# datalib:systems/dev_settings/display/nav/right
# Moves the page-2 cursor right and refreshes the book.

execute unless function datalib:debug/tools/utils/perm_check run return 0

scoreboard players add @s dl.dev_pg2 1
# Wrap: if cursor went above 2, reset to 1 (first slot)
execute if score @s dl.dev_pg2 matches 3.. run scoreboard players set @s dl.dev_pg2 1

function datalib:systems/dev_settings/display/open
