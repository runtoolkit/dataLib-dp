# datalib:systems/geo/region_watch/internal/player_scan
# @s = the player to check
# Reads coordinates to storage, then iterates all regions.

data modify storage datalib:engine _rw_iter set from storage datalib:engine region_watches

# Write player coordinates to _rw_player (int truncation, consistent with geo module)
execute store result storage datalib:engine _rw_player.x int 1 run data get entity @s Pos[0]
execute store result storage datalib:engine _rw_player.y int 1 run data get entity @s Pos[1]
execute store result storage datalib:engine _rw_player.z int 1 run data get entity @s Pos[2]

function datalib:core/internal/systems/geo/region_watch/region_loop

data remove storage datalib:engine _rw_iter
data remove storage datalib:engine _rw_player
