
$execute if entity @s[tag=datalib.admin] run tag @a[name=$(target),limit=1] add datalib.admin
$tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" added as admin.","color":"green"}]
