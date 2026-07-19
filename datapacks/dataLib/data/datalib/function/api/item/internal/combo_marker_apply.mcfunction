# datalib:api/item/internal/combo_marker_apply
# Internal — do not call directly. Second pass of api/item/combo_marker.
# Expects: {player:"...",slot:"...",dataLib:{...}}

$item modify entity @a[name=$(player),limit=1] $(slot) {function:"minecraft:set_components",components:{"minecraft:custom_data":{dataLib:$(dataLib)}}}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"item/combo_marker ","color":"aqua"},{"text":"$(player) ","color":"white"},{"text":"slot=$(slot)","color":"gray"}]
