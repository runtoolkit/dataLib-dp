# datalib:core/cmd/run
# Entry point for the command dispatcher.
# Fires when any player triggers dl_run (via player_systems.mcfunction).
# Expects datalib:input cmd to be set before triggering:
#   data merge storage datalib:input {cmd:{type:"...", data:{...}}}
#   /trigger dl_run set 1
#
# Available types: see datalib:debug/tools/trigger/internal/dispatch for full list.
# Examples:
#   msg         → data:{player:"Name", message:"..."}
#   give        → data:{player:"Name", item:"minecraft:diamond", count:1}
#   gamemode    → data:{player:"Name", mode:"survival"}
#   tp          → data:{player:"Name", x:0, y:64, z:0}
#   effect_add  → data:{player:"Name", effect:"minecraft:speed", duration:100, amplifier:1}
#   score_set   → data:{player:"Name", objective:"obj", value:10}
#   tag_add     → data:{player:"Name", tag:"myTag"}
#   xp          → data:{player:"Name", amount:100, type:"points"}
#   fill        → data:{x1:0,y1:0,z1:0,x2:1,y2:1,z2:1,block:"minecraft:stone"}
#   setblock    → data:{x:0, y:64, z:0, block:"minecraft:stone"}

execute if data storage datalib:input cmd run function datalib:core/cmd/exec
execute unless data storage datalib:input cmd run tellraw @s [{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd: ","color":"aqua"},{"text":"datalib:input cmd not set","color":"red"}]
