tag @s add datalib.ia_active

data modify storage datalib:engine _ia_iter set from storage datalib:engine interaction_binds.use
execute if data storage datalib:engine _ia_iter[0] run execute on target run function datalib:core/internal/api/interaction/dispatch

tag @s remove datalib.ia_active
data remove entity @s interaction
data remove storage datalib:engine _ia_iter
data remove storage datalib:engine _ia_cur
