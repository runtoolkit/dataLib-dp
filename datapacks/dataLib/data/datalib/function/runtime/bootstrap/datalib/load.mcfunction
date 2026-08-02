#> This function will run on datapack loading

execute if data storage datalib:engine {global:{loaded:1b}} run return 0

function #datalib:runtime/load/load_bridge/_private/load