# datalib:core/internal/api/wand/give_lore_exec [1.20.5+]
# Writes wand with lore to mainhand via item replace (component syntax).

$item replace entity @a[name=$(player),limit=1] weapon.mainhand with minecraft:carrot_on_a_stick[minecraft:custom_data={wand:"$(tag)"},minecraft:custom_name='{"text":"$(name)"}',minecraft:lore=['{"text":"$(lore)","italic":false,"color":"$(color)"}'],minecraft:enchantments={levels:{"minecraft:unbreaking":1}},minecraft:hide_additional_tooltip={}]
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/give_lore ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(tag)","color":"aqua"}]}
