execute unless function datalib:debug/tools/utils/check_all run return 0

$advancement revoke @a[name=$(player),limit=1] only $(advancement)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/advancement_revoke ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(advancement)","color":"aqua"}]
