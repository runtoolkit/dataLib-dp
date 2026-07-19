# datalib:debug/tools/admin/debug_tag/disable
# Turns auto_debug_tag OFF: admins no longer get datalib.debug
# automatically. Also strips datalib.debug from every currently
# tagged admin so the effect is immediate, not just "stops granting
# new ones" — otherwise tags handed out by prior ticks would silently
# linger until manually removed, which defeats the point of disabling
# this.
#
# Use datalib:debug/tools/admin/debug_tag/grant / revoke to manage
# datalib.debug per-player once this is disabled.

execute unless function datalib:debug/tools/utils/check_all run return run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]

data modify storage datalib:engine security.auto_debug_tag set value 0b
tag @a[tag=datalib.admin] remove datalib.debug
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"auto_debug_tag ","color":"white"},{"text":"disabled","color":"yellow"},{"text":" — datalib.debug removed from all admins. Use debug_tag/grant to assign it manually.","color":"gray"}]
