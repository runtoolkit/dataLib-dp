# dl_load:load/fork
# Fork confirmation gate — called when fork_verified is not set.
# Player is prompted to confirm with a click or /yes-/no command.
#
# USAGE:
#   /function dl_load:load/fork
#
# CONFIRM:  /function dl_load:load/fork_yes  (or click [Yes])
# CANCEL:   /function dl_load:load/fork_no   (or click [No])

scoreboard objectives add dl.fork_gate dummy

# Reset any stale state from a previous incomplete gate cycle.
# Without this, a #pending=1 left over from a prior session/reload
# (objectives add is idempotent and does NOT reset values) would
# permanently lock this gate: fork_yes/fork_no both guard on
# "#pending matches 1", and the early "drop if already open" check
# below would keep returning before ever re-arming the 30s timeout.
scoreboard players set #pending dl.fork_gate 0
scoreboard players set #confirmed dl.fork_gate 0

scoreboard players set #pending dl.fork_gate 1

tellraw @a ["",{"text":"[DL FORK GATE] ","color":"#555555"},{"text":"This copy is not marked as a fork.","color":"yellow"}]
tellraw @a ["",{"text":"[DL FORK GATE] ","color":"#555555"},{"text":"Do you want to continue?","color":"gray"}]
tellraw @a ["",{"text":"[DL FORK GATE] ","color":"#555555"},{"text":"[Yes]","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/fork_yes"}},{"text":"   ","color":"gray"},{"text":"[No]","color":"red","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function dl_load:load/fork_no"}}]
tellraw @a ["",{"text":"[DL FORK GATE] ","color":"#555555"},{"text":"Auto-cancel fires in 30 seconds.","color":"gray"}]

schedule function dl_load:load/fork_no 30s replace
