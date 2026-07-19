# datalib:debug/tools/admin/debug_tag/grant
# Manually grants datalib.debug to a single player, regardless of the
# auto_debug_tag setting. Intended for use once auto_debug_tag is 0b —
# grants made while it's 1b have no visible effect since the tick
# system re-adds the tag to every admin anyway.
# Usage: /function datalib:debug/tools/admin/debug_tag/grant {target:"PlayerName"}

execute unless function datalib:debug/tools/utils/check_all run return run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]

$tag @a[name=$(target),limit=1] add datalib.debug
$tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" granted datalib.debug.","color":"green"}]
