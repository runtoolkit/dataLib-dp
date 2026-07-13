tag @s add datalib.ia_active

data modify storage datalib:engine _ia_iter set from storage datalib:engine interaction_binds.attack
execute if data storage datalib:engine _ia_iter[0] run execute on attacker run function datalib:core/internal/api/interaction/dispatch

tag @s remove datalib.ia_active
data remove entity @s attack
data remove storage datalib:engine _ia_iter
data remove storage datalib:engine _ia_cur
