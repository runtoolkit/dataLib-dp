# dl_load:gate/exec/ban
# Executor for confirmed ban command.
# Called by dl_load:gate/yes via: function ... with storage datalib:engine pending_gate
#
# Macro fields required in datalib:engine pending_gate:
#   player  — target player name or UUID
#   reason  — ban reason string
#
# MACRO LINE RULES: every $ line must contain at least one $(key).
# No $ lines without $(key) — Minecraft crashes on that.

$ban $(player) $(reason)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/ban ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" — reason: ","color":"gray"},{"text":"$(reason)","color":"yellow"}]
