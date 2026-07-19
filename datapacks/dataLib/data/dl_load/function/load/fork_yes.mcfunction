# dl_load:load/fork_yes
# Fork confirmation gate — /yes response.
# Runs safe_load and sets fork_verified to 0b.
#
# USAGE:
#   /function dl_load:load/fork_yes

# Guard: gate must be open
execute unless score #pending dl.fork_gate matches 1 run return 0

# Guard: already confirmed
execute if score #confirmed dl.fork_gate matches 1 run return 0

scoreboard players set #confirmed dl.fork_gate 1
scoreboard players set #pending dl.fork_gate 0

schedule clear dl_load:load/fork_no

tellraw @a ["",{"text":"[DL FORK GATE] ","color":"#555555"},{"text":"Confirmed","color":"green","bold":true},{"text":" — running safe_load.","color":"gray"}]

# fork_verified = 0b (fork, confirmed by operator)
data modify storage datalib:engine global.fork_verified set value 0b

function dl_load:safe_load/yes

# ── Extension override dependency ──────────────────────────────────
# datalib_extensions marks its own presence via
# #datalib_extensions.present datalib.meta = 1, set on its own
# #minecraft:load hook (extensions/init). This block does not test
# function existence directly — Minecraft has no reliable
# if-function-exists primitive, and a missing function call fails soft
# rather than tripping an if/unless guard — so presence is inferred
# from that flag instead.
#
# Confirmed-fork builds (this file, fork_yes) hand control to
# datalib_extensions:extensions/gate when the dependency is present,
# so override behavior only activates in a build an operator has
# explicitly acknowledged as a fork.
execute if score #datalib_extensions.present datalib.meta matches 1 run function datalib_extensions:extensions/gate
