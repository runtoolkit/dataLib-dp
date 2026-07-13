execute if data storage datalib:engine pb_obj run scoreboard players operation $pb_mod dl.tmp = $epoch datalib.time
execute if data storage datalib:engine pb_obj run scoreboard players operation $pb_mod dl.tmp %= $pb_four dl.tmp
execute if data storage datalib:engine pb_obj run execute if score $pb_mod dl.tmp matches 0 run execute as @a run function datalib:systems/string/progress_bar_self with storage datalib:engine {}
