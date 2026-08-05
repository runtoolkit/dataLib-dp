$summon minecraft:interaction ~ ~ ~ {width:$(width), height:$(height), response:$(response), Tags:["datalib.interaction","datalib.ia_new"]}

$tag @e[type=minecraft:interaction,tag=datalib.ia_new,limit=1,sort=nearest] add $(tag)
tag @e[tag=datalib.ia_new] remove datalib.ia_new

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"interaction/spawn ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" spawned","color":"#555555"}]
