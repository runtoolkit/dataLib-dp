# datalib:core/internal/cmd/ban_apply
# The actual ban logic, run either directly (gates off) or after gate
# confirmation (gates on, the default).
$ban $(player) $(reason)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ban ","color":"aqua"},{"text":"$(player) $(reason)","color":"white"}]
