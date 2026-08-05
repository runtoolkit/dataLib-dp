# datalib:systems/geo/region_watch/internal/check_region [MACRO]
# INPUT (from _rw_cur): $(id), $(x1), $(y1), $(z1), $(x2), $(y2), $(z2)
# @s = the player being checked
# Player coordinates: datalib:engine _rw_player.{x,y,z}

# --- AABB test: return early if outside any axis ---
execute store result score $rwx dl.tmp run data get storage datalib:engine _rw_player.x
execute store result score $rwy dl.tmp run data get storage datalib:engine _rw_player.y
execute store result score $rwz dl.tmp run data get storage datalib:engine _rw_player.z

$scoreboard players set $rwx1 dl.tmp $(x1)
$scoreboard players set $rwy1 dl.tmp $(y1)
$scoreboard players set $rwz1 dl.tmp $(z1)
$scoreboard players set $rwx2 dl.tmp $(x2)
$scoreboard players set $rwy2 dl.tmp $(y2)
$scoreboard players set $rwz2 dl.tmp $(z2)

# min/max normalize
execute if score $rwx1 dl.tmp > $rwx2 dl.tmp run scoreboard players operation $rwt dl.tmp = $rwx1 dl.tmp
execute if score $rwx1 dl.tmp > $rwx2 dl.tmp run scoreboard players operation $rwx1 dl.tmp = $rwx2 dl.tmp
execute if score $rwt dl.tmp > $rwx2 dl.tmp run scoreboard players operation $rwx2 dl.tmp = $rwt dl.tmp
execute if score $rwy1 dl.tmp > $rwy2 dl.tmp run scoreboard players operation $rwt dl.tmp = $rwy1 dl.tmp
execute if score $rwy1 dl.tmp > $rwy2 dl.tmp run scoreboard players operation $rwy1 dl.tmp = $rwy2 dl.tmp
execute if score $rwt dl.tmp > $rwy2 dl.tmp run scoreboard players operation $rwy2 dl.tmp = $rwt dl.tmp
execute if score $rwz1 dl.tmp > $rwz2 dl.tmp run scoreboard players operation $rwt dl.tmp = $rwz1 dl.tmp
execute if score $rwz1 dl.tmp > $rwz2 dl.tmp run scoreboard players operation $rwz1 dl.tmp = $rwz2 dl.tmp
execute if score $rwt dl.tmp > $rwz2 dl.tmp run scoreboard players operation $rwz2 dl.tmp = $rwt dl.tmp

# Inside AABB? 1=inside, 0=outside
scoreboard players set $rw_inside dl.tmp 1
execute if score $rwx dl.tmp < $rwx1 dl.tmp run scoreboard players set $rw_inside dl.tmp 0
execute if score $rwx dl.tmp > $rwx2 dl.tmp run scoreboard players set $rw_inside dl.tmp 0
execute if score $rwy dl.tmp < $rwy1 dl.tmp run scoreboard players set $rw_inside dl.tmp 0
execute if score $rwy dl.tmp > $rwy2 dl.tmp run scoreboard players set $rw_inside dl.tmp 0
execute if score $rwz dl.tmp < $rwz1 dl.tmp run scoreboard players set $rw_inside dl.tmp 0
execute if score $rwz dl.tmp > $rwz2 dl.tmp run scoreboard players set $rw_inside dl.tmp 0

# --- State transition ---
# Was inside and still inside → do nothing
$execute if score $rw_inside dl.tmp matches 1 run execute if entity @s[tag=rw.$(id)] run return 0
# Was outside and still outside → do nothing
$execute if score $rw_inside dl.tmp matches 0 run execute unless entity @s[tag=rw.$(id)] run return 0

# --- on_enter: was outside, now inside ---
$execute if score $rw_inside dl.tmp matches 1 run tag @s add rw.$(id)
# DOT NOTATION: _rw_cur.on_enter (space-separated subpath is invalid)
execute if score $rw_inside dl.tmp matches 1 run execute if data storage datalib:engine _rw_cur.on_enter run function datalib:core/internal/systems/geo/region_watch/fire_enter with storage datalib:engine _rw_cur
execute if score $rw_inside dl.tmp matches 1 run execute if data storage datalib:engine _rw_cur.on_enter_cmd run function datalib:core/internal/systems/geo/region_watch/fire_enter_cmd with storage datalib:engine _rw_cur
execute if score $rw_inside dl.tmp matches 1 run return 0

# --- on_leave: was inside, now outside ---
$tag @s remove rw.$(id)
execute if data storage datalib:engine _rw_cur.on_leave run function datalib:core/internal/systems/geo/region_watch/fire_leave with storage datalib:engine _rw_cur
execute if data storage datalib:engine _rw_cur.on_leave_cmd run function datalib:core/internal/systems/geo/region_watch/fire_leave_cmd with storage datalib:engine _rw_cur
