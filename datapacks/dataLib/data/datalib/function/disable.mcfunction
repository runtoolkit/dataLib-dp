playsound minecraft:block.note_block.pling master @s ~ ~ ~ 4 2

function datalib:core/disable/main

tellraw @s [{"text":"To restart:"}," ",{"text":"/reload","color":"aqua","bold":true,"italic":false,"click_event": {"action": "run_command", "command": "/reload"}}]
