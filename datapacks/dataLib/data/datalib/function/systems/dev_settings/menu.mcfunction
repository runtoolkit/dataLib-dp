# datalib:systems/dev_settings/menu
# Dev Settings panel — part of #datalib:admin/menu.
# Displays a written book GUI with devMode toggle and version selector.
# Requires: dl.perm_level >= security.admin_min_level

execute unless function datalib:debug/tools/utils/perm_check run return 0

# Header separator
tellraw @s ["",{"text":"─── Dev Settings ────────────────────","color":"#FFAA00","bold":true}]

# Inline quick-status line in chat, then offer book
tellraw @s ["",{"text":"  devMode  ","color":"gray"},{"storage":"datalib:engine","nbt":"dev_settings.devMode","color":"gold"},{"text":"    version  ","color":"gray"},{"storage":"datalib:engine","nbt":"dev_settings.version","color":"aqua"}]
tellraw @s ["",{"text":"  "},{"text":"[Open Book]","color":"light_purple","hover_event":{"action":"show_text","value":"Opens the interactive Dev Settings book"},"click_event":{"action":"run_command","command":"/function datalib:systems/dev_settings/display/open"}}]
