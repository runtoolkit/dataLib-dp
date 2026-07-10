# ─────────────────────────────────────────────────────────────────
# datalib:systems/flag/set_if
# Sets a flag only when a scoreboard condition is met.
# Condition: score of $(score_holder) in $(objective) must match $(matches).
# Uses scoreboard matches syntax (e.g. "1", "1..5", "..0", "2..").
#
# INPUT : $(key)          → flag key
#         $(score_holder) → scoreboard entity/fake-player name
#         $(objective)    → scoreboard objective
#         $(matches)      → match range string (e.g. "1..")
# OUTPUT: datalib:output result → 1b if flag was set, 0b if condition not met
#
# EXAMPLE:
# function datalib:systems/flag/set_if {key:"night_mode",score_holder:"$time",objective:"dl.tmp",matches:"..12000"}
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output result set value 0b
$execute if score $(score_holder) $(objective) matches $(matches) run data modify storage datalib:engine flags.$(key) set value 1b
$execute if score $(score_holder) $(objective) matches $(matches) run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"flag/set_if ","color":"aqua"},{"text":"$(key) if $(score_holder) $(objective) matches $(matches) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
