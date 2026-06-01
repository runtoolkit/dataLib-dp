execute as @a run function datalib:core/lib/tick_guard_clear

execute as @a[scores={dl_menu=1..}] run function datalib:menu
scoreboard players set @a[scores={dl_menu=1..}] dl_menu 0
scoreboard players enable @a[scores={dl_menu=-1..}] dl_menu

execute as @a[scores={macro_run=1..}] run function #datalib:admin/run
scoreboard players set @a[scores={macro_run=1..}] datalib_run 0
scoreboard players enable @a[scores={macro_run=-1..}] datalib_run

execute as @a[scores={macro_action=1..}] run function datalib:core/internal/api/trigger/dispatch

function datalib:core/internal/api/interaction/tick_scan

function datalib:core/internal/api/perm/trigger/tick_start

function datalib:core/internal/api/wand/tick_scan

function datalib:core/internal/systems/hook/tick_scan

function datalib:core/internal/systems/geo/region_watch/tick_scan
# Event bus — on_tick
function #datalib:events/on_tick
