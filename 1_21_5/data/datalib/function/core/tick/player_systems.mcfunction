execute as @a[scores={dl_menu=1..}] run function datalib:menu
scoreboard players set @a[scores={dl_menu=1..}] dl_menu 0
scoreboard players enable @a[scores={dl_menu=-1..}] dl_menu

execute as @a[scores={dl_run=1..}] run function #datalib:run
scoreboard players set @a[scores={dl_run=1..}] dl_run 0
scoreboard players enable @a[scores={dl_run=-1..}] dl_run

execute as @a[scores={dl_action=1..}] run function datalib:core/internal/api/trigger/dispatch

function datalib:core/internal/api/interaction/tick_scan

function datalib:core/internal/api/perm/trigger/tick_start

function datalib:core/internal/api/wand/tick_scan
function datalib:core/internal/systems/hook/tick_scan

function datalib:core/internal/systems/geo/region_watch/tick_scan
function datalib:core/internal/api/cmd/freeze/tick