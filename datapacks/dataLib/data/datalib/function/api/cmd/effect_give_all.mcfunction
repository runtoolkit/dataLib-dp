execute unless function datalib:debug/tools/utils/check_all run return 0

$effect give @a $(effect) $(duration) $(amplifier) $(hide)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/effect_give_all ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(effect)","color":"aqua"}]
