# datalib:player/internal/init_from_name [MACRO]
# Relay: storage datalib:names temp {NAME:"<player>"} → datalib:player/init
# Called by on_player_join after datalib:player/get_name populates datalib:names temp.
# Bridges the NAME key to the player key expected by player/init.

$data modify storage datalib:engine _pid_init_tmp set value {player:"$(NAME)"}
function datalib:player/init with storage datalib:engine _pid_init_tmp
data remove storage datalib:engine _pid_init_tmp
