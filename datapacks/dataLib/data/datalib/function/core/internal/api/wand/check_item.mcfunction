# datalib:api/wand/internal/check_item [MACRO]
# $(tag) → custom_data tag name
# If the item in the player's main hand has this tag, run the bind.

$execute if items entity @s weapon.mainhand *[minecraft:custom_data~{wand:"$(tag)"}] run function datalib:core/internal/api/wand/fire with storage datalib:engine _wand_current
