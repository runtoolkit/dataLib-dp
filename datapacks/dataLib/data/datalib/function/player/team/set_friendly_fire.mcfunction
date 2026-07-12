$team modify $(team) friendlyFire $(value)
$data modify storage datalib:engine teams.$(team).friendly_fire set value "$(value)"
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"team/set_friendly_fire ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
