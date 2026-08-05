

$damage @a[name=$(player),limit=1] $(amount) $(damage_type)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/damage_typed ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(amount)","color":"aqua"}]
