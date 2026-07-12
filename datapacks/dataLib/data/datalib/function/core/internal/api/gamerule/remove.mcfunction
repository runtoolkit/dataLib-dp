# datalib:api/gamerule/internal/remove [MACRO]
# Removes a single gamerule key from engine storage.
# Called by reset only.
$data remove storage datalib:engine gamerules.$(_gamerule_norm)
