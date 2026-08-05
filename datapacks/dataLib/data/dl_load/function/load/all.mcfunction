# dl_load:load/all — full init pipeline (no fork / rt_origin / confirm gates)

tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Starting dataLib...","color":"gray"}]

# forceload classic marker chunk (legacy features)
forceload add -30000000 1600

function dl_load:loader/scoreboards
function dl_load:loader/storages
function dl_load:loader/other

# Re-apply config after storages (storages may reset defaults)
function datalib:config

data modify storage datalib:engine global.loaded set value 1b

schedule function dl_load:load/final 1s
