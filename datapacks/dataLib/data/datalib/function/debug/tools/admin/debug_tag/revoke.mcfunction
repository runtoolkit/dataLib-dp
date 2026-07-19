# datalib:debug/tools/admin/debug_tag/revoke
# Manually removes datalib.debug from a single player. If
# auto_debug_tag is still 1b and the target is a datalib.admin, the
# tag reappears on the next tick — revoke is only durable once
# auto_debug_tag is 0b.
# Usage: /function datalib:debug/tools/admin/debug_tag/revoke {target:"PlayerName"}

execute unless function datalib:debug/tools/utils/check_all run return run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]

$tag @a[name=$(target),limit=1] remove datalib.debug
$tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" — datalib.debug revoked.","color":"gray"}]
