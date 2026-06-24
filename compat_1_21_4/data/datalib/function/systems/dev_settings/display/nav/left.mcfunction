# datalib:systems/dev_settings/display/nav/left
# Moves the page-2 cursor left and refreshes the book.

execute unless function datalib:debug/tools/utils/perm_check run return 0

scoreboard players remove @s dl.dev_pg2 1
# Wrap: if cursor went below 1, reset to 2 (last slot)
execute if score @s dl.dev_pg2 matches ..0 run scoreboard players set @s dl.dev_pg2 2

function datalib:systems/dev_settings/display/open
