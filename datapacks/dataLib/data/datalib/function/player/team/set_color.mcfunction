$team modify $(team) color $(color)
$data modify storage datalib:engine teams.$(team).color set value "$(color)"
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"team/set_color ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
