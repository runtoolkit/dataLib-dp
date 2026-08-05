$team remove $(team)
$data remove storage datalib:engine teams.$(team)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"team/delete ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
