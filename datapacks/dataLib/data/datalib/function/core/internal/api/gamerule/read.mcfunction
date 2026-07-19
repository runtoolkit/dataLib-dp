# datalib:api/gamerule/internal/read [MACRO]
# Reads gamerule value from engine storage into output.
# Called by get only.
$execute if data storage datalib:engine gamerules.$(_gamerule_norm) run data modify storage datalib:output gamerule set from storage datalib:engine gamerules.$(_gamerule_norm)
