# datalib:api/toggle/show
# 1.21.4 compat: dialog show is not available before 1.21.6.
# Displays module toggle status via tellraw instead.

execute unless entity @s[tag=datalib.admin] run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Module Toggles","color":"aqua","bold":true}]
tellraw @s ["",{"text":" hook: ","color":"gray"},{"score":{"name":"#m_hook","objective":"datalib.Flags"},"color":"green"},{"text":"  interaction: ","color":"gray"},{"score":{"name":"#m_interaction","objective":"datalib.Flags"},"color":"green"}]
tellraw @s ["",{"text":" perm: ","color":"gray"},{"score":{"name":"#m_perm","objective":"datalib.Flags"},"color":"green"},{"text":"  wand: ","color":"gray"},{"score":{"name":"#m_wand","objective":"datalib.Flags"},"color":"green"},{"text":"  geo: ","color":"gray"},{"score":{"name":"#m_geo","objective":"datalib.Flags"},"color":"green"}]
tellraw @s ["",{"text":"Use ","color":"dark_gray"},{"text":"/function datalib:api/toggle/<module>/<true|false>","color":"yellow"},{"text":" to change.","color":"dark_gray"}]
