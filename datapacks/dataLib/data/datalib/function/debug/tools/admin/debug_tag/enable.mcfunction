# datalib:debug/tools/admin/debug_tag/enable
# Turns auto_debug_tag back ON: every admin (datalib.admin tag) is
# granted datalib.debug automatically each tick (legacy default).


data modify storage datalib:engine security.auto_debug_tag set value 1b
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"auto_debug_tag ","color":"white"},{"text":"enabled","color":"green"},{"text":" — admins get datalib.debug automatically again.","color":"gray"}]
