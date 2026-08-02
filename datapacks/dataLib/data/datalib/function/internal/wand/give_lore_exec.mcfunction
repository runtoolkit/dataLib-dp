# datalib:api/wand/internal/give_lore_exec [MACRO]
# INPUT (macro): $(player), $(tag), $(name), $(lore), $(color)
#
# Writes with lore directly to mainhand via item replace weapon.mainhand.
# Not give but item replace — places directly in slot 0 (mainhand).

$item replace entity @a[name=$(player),limit=1] weapon.mainhand with minecraft:carrot_on_a_stick[minecraft:custom_data={wand:"$(tag)"},minecraft:item_name={"text":"$(name)"},minecraft:lore=[{"text":"$(lore)","italic":false,"color":"$(color)"}],minecraft:enchantment_glint_override=true]

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/give_lore ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(tag)","color":"aqua"}]
