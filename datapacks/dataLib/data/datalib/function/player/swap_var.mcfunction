$data modify storage datalib:engine _swap.tmp set from storage datalib:engine players.$(player_a).$(key)
$data modify storage datalib:engine players.$(player_a).$(key) set from storage datalib:engine players.$(player_b).$(key)
$data modify storage datalib:engine players.$(player_b).$(key) set from storage datalib:engine _swap.tmp
data remove storage datalib:engine _swap
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/swap_var ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]