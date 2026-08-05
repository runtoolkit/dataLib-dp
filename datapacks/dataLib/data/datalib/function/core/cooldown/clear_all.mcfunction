$data remove storage datalib:engine cooldowns.$(player)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/clear_all ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(player)","color":"white"},{"text":" — all cooldowns cleared","color":"#555555"}]
