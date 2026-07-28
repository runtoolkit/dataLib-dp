kill @e[type=minecraft:minecart,tag=datalib_input,sort=nearest,limit=1,distance=..2]
kill @e[type=minecraft:interaction,tag=datalib_input,sort=nearest,limit=1,distance=..2]
execute as @s at @s run summon minecraft:interaction ~ ~ ~ {width:1.0f,height:1.0f,Tags:["datalib_input"],Passengers:[{id:"minecraft:command_block_minecart",Tags:["datalib_input"]}]}