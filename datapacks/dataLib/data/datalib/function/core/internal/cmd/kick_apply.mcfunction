# datalib:core/internal/cmd/kick_apply
# The actual kick logic, run either directly (gates off) or after gate
# confirmation (gates on, the default).
$kick $(player) $(reason)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/kick ","color":"aqua"},{"text":"$(player) $(reason)","color":"white"}]
