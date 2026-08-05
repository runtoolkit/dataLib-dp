# datalib_extensions:extensions/gate
#
# Called from dl_load:load/fork_yes, immediately after an operator
# confirms this build is a fork (fork_verified set to 0b) and only
# when datalib_extensions is present in the build.
#
# This is the override entry point: extension-specific features and
# gates for confirmed-fork builds go here. Currently a placeholder —
# fill in with whatever fork-specific behavior datalib_extensions is
# meant to provide.

summon minecraft:marker ~ ~ ~ {Tags:["datalib.ext_gate"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.ext_gate,limit=1] run say [DL EXT] datalib_extensions gate — fork confirmed, override active.
execute as @e[type=minecraft:marker,tag=datalib.ext_gate,limit=1] run kill @s

# TODO: extension-specific fork-override logic goes here.
