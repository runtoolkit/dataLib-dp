# datalib:core/config/exec [MACRO]
# Runs a function if the config score matches a range.
# Works with values stored on datalib.config scoreboard via score_set.
#
# INPUT (macro args):
#   $(key)     — scoreboard fake player name (e.g. "damage")
#   $(matches) — score range string (e.g. "1..", "5", "1..10")
#   $(func)    — function to run if condition is true
#
# USAGE:
#   data modify storage datalib:input key set value "pvp_enabled"
#   data modify storage datalib:input matches set value "1.."
#   data modify storage datalib:input func set value "mypack:on_pvp"
#   function datalib:core/config/exec with storage datalib:input {}
#
# EXAMPLE (bind a command instead of func):
#   Use score_set to write the value, then check inline:
#   execute if score #pvp_enabled datalib.config matches 1.. run function mypack:on_pvp
$execute if score #$(key) datalib.config matches $(matches) run function $(func)
