# datalib:core/cooldown/pause
# Pauses an active cooldown, saving the remaining ticks.
# Params: player, key
# Output: datalib:output result (remaining ticks saved), 0b if not active

data modify storage datalib:output result set value 0b

$execute unless data storage datalib:engine cooldowns.$(player).$(key) run return 0

# Calculate remaining ticks
$execute store result score $cdp_exp dl.tmp run data get storage datalib:engine cooldowns.$(player).$(key)
execute store result score $cdp_now dl.tmp run scoreboard players get $epoch datalib.time
scoreboard players operation $cdp_exp dl.tmp -= $cdp_now dl.tmp

# Only pause if actually still active
execute unless score $cdp_exp dl.tmp matches 1.. run return 0

# Save remaining ticks to paused storage and clear the live cooldown
$execute store result storage datalib:engine paused_cooldowns.$(player).$(key) int 1 run scoreboard players get $cdp_exp dl.tmp
$data remove storage datalib:engine cooldowns.$(player).$(key)
execute store result storage datalib:output result int 1 run scoreboard players get $cdp_exp dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/pause ","color":"aqua"},{"text":"⏸ ","color":"yellow"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"},{"text":"t remaining","color":"#555555"}]
