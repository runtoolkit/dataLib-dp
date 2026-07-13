execute unless entity @s[tag=datalib.admin] run return run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]

$data remove storage datalib:engine permissions.$(player)
$advancement revoke @a[name=$(player),limit=1] from datalib:hidden/root
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"perm/clear ","color":"aqua"},{"text":"⚠ ","color":"yellow"},{"text":"$(player)","color":"white"},{"text":" — all permissions cleared","color":"#555555"}]
