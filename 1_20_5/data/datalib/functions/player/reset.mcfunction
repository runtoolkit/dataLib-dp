$data remove storage datalib:engine players.$(player)
$data remove storage datalib:engine cooldowns.$(player)
$advancement revoke @a[name=$(player),limit=1] from datalib:hidden/root
$data modify storage datalib:engine _pid_init_tmp set value {player:"$(player)"}
function datalib:player/init with storage datalib:engine _pid_init_tmp
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/reset ","color":"aqua"},{"text":"$(player)","color":"white"}]}
