# Force full re-init (explicit data loss of engine flags)
data remove storage datalib:engine global.loaded
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Force re-init...","color":"yellow"}]
function dl_load:load/all
