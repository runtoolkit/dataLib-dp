$effect give @e[type=$(type),tag=$(tag)] $(effect) $(duration) $(amplifier) true
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/give_effect ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(effect)","color":"aqua"}]
