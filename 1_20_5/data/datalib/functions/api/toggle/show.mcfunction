# datalib:api/toggle/show
# Opens the module toggle menu (1.20.5 compat: tellraw + clickEvent).
# The main pack uses "dialog show" which only exists from 1.21.6 onward.
# Confirmed failing under mecha 1.20 target before this fix.

execute unless entity @s[tag=datalib.admin] run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Toggle a module ━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":"  hook        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/hook/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/hook/false"}}]
tellraw @s ["",{"text":"  interaction ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/interaction/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/interaction/false"}}]
tellraw @s ["",{"text":"  perm        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/perm/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/perm/false"}}]
tellraw @s ["",{"text":"  wand        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/wand/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/wand/false"}}]
tellraw @s ["",{"text":"  geo         ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/geo/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/geo/false"}}]
tellraw @s ["",{"text":"  cb          ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/cb/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/cb/false"}}]
tellraw @s ["",{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/show","color":"aqua"},{"text":" → opened (1.20.5 tellraw menu)","color":"gray"}]
