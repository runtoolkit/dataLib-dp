# dl_load:load/force
# Gated force reload: if the gate system is active (datalib:engine
# sandbox:1b, the default), route through confirmation — force reload
# discards live engine state (global.loaded and everything load/all's
# "unless data" guards would otherwise preserve), so it is a dangerous
# action in the same class as ban/kick/disable. If gates were turned
# off via gate/toggle/disable, apply directly like before.

execute if data storage datalib:engine {sandbox:1b} run return run function dl_load:gate/request {type:"load_force",label:"Force reload dataLib (discards live engine state)",action:"datalib:core/internal/load/force_apply",args:{}}

function datalib:core/internal/load/force_apply
