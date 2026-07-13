execute unless function datalib:debug/tools/utils/check_all run return 0

$attribute @a[name=$(player),limit=1] $(attribute) modifier remove $(id)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/attribute_remove_modifier ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]
