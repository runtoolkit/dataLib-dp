# datalib:api/item/internal/hidden_flag_apply
# Internal — do not call directly. Second pass of api/item/hidden_flag.
# Expects: {player:"...",slot:"...",dataLib:{...}}

$item modify entity @a[name=$(player),limit=1] $(slot) {function:"minecraft:set_components",components:{"minecraft:custom_data":{dataLib:$(dataLib)}}}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"item/hidden_flag ","color":"aqua"},{"text":"$(player) ","color":"white"},{"text":"slot=$(slot)","color":"gray"}]
