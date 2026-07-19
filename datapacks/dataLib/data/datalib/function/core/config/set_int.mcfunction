$execute store result storage datalib:engine config.$(key) int 1 run scoreboard players set $cfg_tmp dl.tmp $(value)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"config/set_int ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
