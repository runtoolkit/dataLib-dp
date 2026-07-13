# datalib:core/cooldown/resume
# Resumes a previously paused cooldown.
# Params: player, key
# Output: datalib:output result (new expiry epoch tick), 0b if not paused

data modify storage datalib:output result set value 0b

$execute unless data storage datalib:engine paused_cooldowns.$(player).$(key) run return 0

# Reconstruct expiry: now + saved remaining ticks
$execute store result score $cdr_rem dl.tmp run data get storage datalib:engine paused_cooldowns.$(player).$(key)
execute store result score $cdr_now dl.tmp run scoreboard players get $epoch datalib.time
scoreboard players operation $cdr_now dl.tmp += $cdr_rem dl.tmp

# Write back to live cooldowns, remove from paused
$execute store result storage datalib:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $cdr_now dl.tmp
$data remove storage datalib:engine paused_cooldowns.$(player).$(key)
execute store result storage datalib:output result int 1 run scoreboard players get $cdr_now dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/resume ","color":"aqua"},{"text":"▶ ","color":"green"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" resumed (","color":"#555555"},{"score":{"name":"$cdr_rem","objective":"dl.tmp"},"color":"yellow"},{"text":"t remaining)","color":"#555555"}]
