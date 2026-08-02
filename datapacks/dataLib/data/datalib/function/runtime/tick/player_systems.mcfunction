execute as @a[scores={dl_menu=1..}] run function datalib:tooling/menu
scoreboard players set @a[scores={dl_menu=1..}] dl_menu 0
scoreboard players enable @a[scores={dl_menu=-1..}] dl_menu

execute as @a[scores={dl_run=1..}] run function #datalib:run
scoreboard players set @a[scores={dl_run=1..}] dl_run 0
scoreboard players enable @a[scores={dl_run=-1..}] dl_run

execute as @a[scores={dl_action=1..}] run function datalib:internal/trigger/dispatch

function datalib:internal/interaction/tick_scan

function datalib:internal/perm/trigger/tick_start

scoreboard players remove @a[scores={datalib.dialog_load=1..}] datalib.dialog_load 1

# Countdown actionbar: show remaining ticks while dialog is loading
#execute as @a[scores={datalib.dialog_load=1..},tag=datalib.dialog_opened,tag=!datalib.dialog_closed] run title @s actionbar ["",{"text":"Loading ","color":"aqua","bold":true},{"score":{"name":"@s","objective":"datalib.dialog_load"},"color":"yellow","bold":true},{"text":" ticks","color":"gray"}]
execute as @a[scores={datalib.dialog_load=1..}] run title @s actionbar ["",{"text":"Loading ","color":"aqua","bold":true},{"score":{"name":"@s","objective":"datalib.dialog_load"},"color":"yellow","bold":true},{"text":" ticks","color":"gray"}]

execute as @a[scores={datalib.dialog_load=0},tag=datalib.dialog_closed] at @s run function datalib:api/dialog/open
execute as @a[scores={datalib.dialog_load=0},tag=!datalib.dialog_closed,tag=!datalib.dialog_opened] at @s run function datalib:api/dialog/open

function datalib:internal/wand/tick_scan
function datalib:internal/hook/tick_scan

function datalib:internal/geo/region_watch/tick_scan
function datalib:internal/cmd/freeze/tick