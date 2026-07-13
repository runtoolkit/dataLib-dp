# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/utils/add_command
# Add a command to queue at runtime
#
# INPUT (storage datalib:input):
# cmd or func → command/function to add
# ─────────────────────────────────────────────────────────────────

execute if data storage datalib:input cmd run data modify storage datalib:engine _mcmd_queue append value {}
execute if data storage datalib:input cmd run data modify storage datalib:engine _mcmd_queue[-1].cmd set from storage datalib:input cmd

execute if data storage datalib:input func run data modify storage datalib:engine _mcmd_queue append value {}
execute if data storage datalib:input func run data modify storage datalib:engine _mcmd_queue[-1].func set from storage datalib:input func

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/utils/add ","color":"aqua"},{"text":"✔ added to queue","color":"green"}]
