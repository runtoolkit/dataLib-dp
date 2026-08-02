$execute as @a[name=$(player),limit=1] unless entity @s[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)] run $(invoke)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"geo/in_region_unless ","color":"aqua"},{"text":"$(player)","color":"white"}]
