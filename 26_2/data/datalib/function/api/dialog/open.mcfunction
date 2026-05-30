scoreboard players set @s datalib.dialog_load -1
tag @s remove datalib.dialog_closed

tag @s remove datalib.dialog_opened


execute unless data storage datalib:engine dialog.DIALOG run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Dialog Not Found","color":"red","bold":false,"italic":false}]}}
execute if data storage datalib:engine {dialog:{DIALOG:""}} run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown Dialog","color":"red","bold":false,"italic":false}]}}
execute unless data storage datalib:engine dialog.DIALOG.type run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown Dialog Type","color":"red","bold":false,"italic":false}]}}
execute unless data storage datalib:engine dialog.DIALOG.title run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Missing Dialog Title","color":"red","bold":false,"italic":false}]}}
execute if data storage datalib:engine {dialog:{DIALOG:{type:"multi_action"}}} unless data storage datalib:engine dialog.DIALOG.actions run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Missing Actions","color":"red","bold":false,"italic":false}]}}

execute if data storage datalib:engine dialog.DIALOG run function datalib:api/dialog/internal/show
execute if data storage datalib:engine dialog.DIALOG run function datalib:api/dialog/notify_admins

return 1