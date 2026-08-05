
$execute if entity @s[tag=datalib.admin] run tag @a[name=$(target),limit=1] remove datalib.admin
$tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" removed from admins.","color":"green"}]
