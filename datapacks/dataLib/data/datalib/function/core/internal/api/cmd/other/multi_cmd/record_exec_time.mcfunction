# Record execution time for profiling
execute store result score $mcmd_exec_end dl.tmp run time query gametime
scoreboard players operation $mcmd_exec_dur dl.tmp = $mcmd_exec_end dl.tmp
scoreboard players operation $mcmd_exec_dur dl.tmp -= $mcmd_exec_start dl.tmp

scoreboard players reset $mcmd_exec_start dl.tmp
scoreboard players reset $mcmd_exec_end dl.tmp
scoreboard players reset $mcmd_exec_dur dl.tmp
