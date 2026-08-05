
$bossbar add $(id) {"text":"$(text)"}
$bossbar set $(id) color $(color)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/bossbar_add ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]
