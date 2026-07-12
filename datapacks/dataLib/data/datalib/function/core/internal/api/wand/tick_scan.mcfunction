# datalib:api/wand/internal/tick_scan
# Every tick: detect players with datalib.rightClick score 1+,
# check their held item, run the matching bind.

# Module toggle guard — skips this module when disabled via datalib:api/toggle/wand/false
execute unless data storage datalib:engine {modules:{wand:1b}} run return 0

execute unless data storage datalib:engine wand_binds[0] run return 0

execute as @a[scores={datalib.rightClick=1..}] at @s run function datalib:core/internal/api/wand/dispatch
scoreboard players set @a[scores={datalib.rightClick=1..}] datalib.rightClick 0
