#> This function will run on datapack loading

return run tellraw @a {"text":"[dataLib] This datapack is ARCHIVED and no longer maintained. It will NOT load. To load it anyway, manually run: function #load:_private/load","color":"red"}

execute if data storage datalib:engine {global:{loaded:1b}} run return 0

function #load:_private/load
