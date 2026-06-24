execute if data storage datalib:engine global{loaded:1b} run return 0

execute unless entity @a run return run function datalib:load

tellraw @a {"text":"⚠ Warning: Bu dunya deneysel ozellikler iceriyor. You can load it with /function datalib:load.","color":"yellow"}
