execute unless function datalib:debug/tools/utils/check_all run return run tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]}

$execute if entity @s[tag=datalib.admin] run tag @a[name=$(target),limit=1] remove datalib.admin
$tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(NAME)","color":"white"},{"text":" removed from admins.","color":"green"}]}
