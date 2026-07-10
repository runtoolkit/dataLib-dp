# DL Tick — Rate/Offset Check [MACRO]
# Fires when (#tick_ctr - offset) % rate == 0.
# Input: $(rate), $(offset), $(fn), $(condition)
#
# rate:1 = every tick | rate:20 = every second | rate:200 = every 10s
# offset: phase shift, spreads channels so they don't all run on the same tick

$scoreboard players set #rate datalib.tick $(rate)
$scoreboard players set #offset datalib.tick $(offset)

# Compute modular position
scoreboard players operation #check datalib.tick = #tick_ctr datalib.tick
scoreboard players operation #check datalib.tick -= #offset datalib.tick
scoreboard players operation #check datalib.tick %= #rate datalib.tick

# Fix negative remainder (possible when tick_ctr < offset at world start)
execute if score #check datalib.tick matches ..-1 run scoreboard players operation #check datalib.tick += #rate datalib.tick

# Not this tick → skip
execute unless score #check datalib.tick matches 0 run return 0

# Passed → execute channel function
execute if data storage datalib:tick_work channel{condition:""} run function datalib:core/tick/dispatch/exec with storage datalib:tick_work channel
execute unless data storage datalib:tick_work channel{condition:""} run function datalib:core/tick/dispatch/exec2 with storage datalib:tick_work channel