playsound minecraft:block.note_block.pling master @s ~ ~ ~ 4 2

function datalib:core/disable/main

tellraw @s [{"text":"To restart:"}," ",{"text":"/datapack enable 'file/dataLib.zip'","color":"aqua","bold":true,"italic":false,"click_event": {"action": "run_command", "command": "/datapack enable 'file/dataLib.zip'"}},", ",{"text":"/datapack enable 'file/dataLib'","color":"aqua","bold":true,"italic":false,"click_event": {"action": "run_command", "command": "/datapack enable 'file/dataLib'"}}," or",{"text":"/datapack enable 'file/datalib-full.zip'","color":"aqua","bold":true,"italic":false,"click_event": {"action": "run_command", "command": "/datapack enable 'file/datalib-full.zip'"}}]
