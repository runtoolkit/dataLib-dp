data modify storage datalib:output multiCommands.executed set value 0b

execute at @s store success storage datalib:output multiCommands.executed byte 1 unless function datalib:api/cmd/other/multi_cmd/advanced/run_with_options run return 1