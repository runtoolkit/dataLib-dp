execute unless function datalib:debug/tools/utils/check_all run return 0

$bossbar set $(id) players $(players)$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/bossbar_set_players ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]
