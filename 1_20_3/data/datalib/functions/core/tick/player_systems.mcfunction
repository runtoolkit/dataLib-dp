
execute as @a[scores={dl_menu=1..}] run function datalib:menu
scoreboard players set @a[scores={dl_menu=1..}] dl_menu 0
scoreboard players enable @a[scores={dl_menu=-1..}] dl_menu

execute as @a[scores={dl_run=1..}] run function #datalib:admin/run
scoreboard players set @a[scores={dl_run=1..}] dl_run 0
scoreboard players enable @a[scores={dl_run=-1..}] dl_run

execute as @a[scores={dl_action=1..}] run function datalib:api/trigger/internal/dispatch

function datalib:api/interaction/internal/tick_scan

function datalib:api/perm/trigger/internal/tick_start

function datalib:api/wand/internal/tick_scan

function datalib:systems/hook/internal/tick_scan

function datalib:systems/geo/region_watch/internal/tick_scan
# Event bus — on_tick
function #datalib:events/on_tick
