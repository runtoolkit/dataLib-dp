# datalib:api/item/internal/use_cooldown_apply
# Internal — do not call directly. Final pass of api/item/use_cooldown.
# Expects: {player:"...",slot:"...",dataLib:{...}}

$item modify entity @a[name=$(player),limit=1] $(slot) {function:"minecraft:set_components",components:{"minecraft:custom_data":{dataLib:$(dataLib)}}}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"item/use_cooldown ","color":"aqua"},{"text":"$(player) ","color":"white"},{"text":"slot=$(slot)","color":"gray"}]
