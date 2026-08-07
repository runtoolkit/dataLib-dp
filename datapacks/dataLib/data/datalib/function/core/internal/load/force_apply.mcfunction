# datalib:core/internal/load/force_apply
# Runs after gate confirmation (or immediately if gates are disabled).
# Actually performs the force re-init: drops the loaded flag and
# re-runs the full init pipeline, discarding any live engine state
# that dl_load:load/all's "unless data" guards would otherwise preserve.

data remove storage datalib:engine global.loaded
tellraw @a ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Force re-init...","color":"yellow"}]
function dl_load:load/all
