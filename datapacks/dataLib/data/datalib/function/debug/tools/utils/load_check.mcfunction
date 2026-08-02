# datalib:debug/menu/tools/utils/load_check
# Returns 1 if engine is loaded, 0 (+ fallback) if not.
execute if data storage datalib:engine global{loaded:1b} run return 1
function datalib:runtime/fallback/not_loaded
return 0
