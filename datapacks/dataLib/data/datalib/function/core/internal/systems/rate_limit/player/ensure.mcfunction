# datalib:systems/rate_limit/player/internal/ensure — Seed player bucket from template [MACRO]
# Input: $(tpl), $(full)
# Called only when bucket doesn't exist yet for this player.

$execute unless data storage datalib:engine rate_limit.player_templates.$(tpl) run return 0
$data modify storage datalib:engine "rate_limit.rules.$(full)" set from storage datalib:engine rate_limit.player_templates.$(tpl)
$data modify storage datalib:engine "rate_limit.rules.$(full).hits" set value []
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"rate_limit ","color":"aqua"},{"text":"INIT ","color":"#55FFFF"},{"text":"player bucket: ","color":"#555555"},{"text":"$(full)","color":"white"}]
