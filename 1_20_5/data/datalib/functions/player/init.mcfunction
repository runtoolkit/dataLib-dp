$execute unless data storage datalib:engine players.$(player) run data modify storage datalib:engine players.$(player) set value {}
$execute unless data storage datalib:engine players.$(player).coins run data modify storage datalib:engine players.$(player).coins set value 0
$execute unless data storage datalib:engine players.$(player).level run data modify storage datalib:engine players.$(player).level set value 1
$execute unless data storage datalib:engine players.$(player).xp run data modify storage datalib:engine players.$(player).xp set value 0
$data modify storage datalib:engine players.$(player).online set value 1b
$execute unless data storage datalib:engine players.$(player).first_join_tick run execute store result storage datalib:engine players.$(player).first_join_tick int 1 run scoreboard players get $epoch datalib.time
$execute store result storage datalib:engine players.$(player).last_join_tick int 1 run scoreboard players get $epoch datalib.time
$execute unless data storage datalib:engine player_pids.$(player) run function datalib:core/internal/player/assign_pid with storage datalib:engine _pid_init_tmp
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"player/init ","color":"aqua"},{"text":"$(player)","color":"white"}]}
