# dl_load:gate/exec/ban_ip
# Executor for confirmed ban-ip command.
# Called by dl_load:gate/yes via: function ... with storage datalib:engine pending_gate
#
# Macro fields required in datalib:engine pending_gate:
#   player  — target player name or UUID (resolves to IP)
#   reason  — ban reason string

$ban-ip $(player) $(reason)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ban_ip ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" — reason: ","color":"gray"},{"text":"$(reason)","color":"yellow"}]
