$team add $(team)
$data modify storage datalib:engine teams.$(team) set value {color:"white",friendly_fire:"true",see_friendly_invisibles:"false"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"team/create ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
