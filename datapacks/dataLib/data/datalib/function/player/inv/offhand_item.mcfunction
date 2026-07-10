# ─────────────────────────────────────────────────────────────────
# datalib:player/inv/offhand_item
# Runs a command/function for each player in @a whose offhand
# matches the given item id and custom data.
# Mirrors the pattern of datalib:player/inv/selected_item (mainhand).
#
# INPUT : $(item)       → item id (e.g. "minecraft:shield")
#         $(customData) → custom_data compound to match (e.g. "{my_tag:1b}")
#         $(invoke)     → command to run as the matching player
#
# EXAMPLE:
# function datalib:player/inv/offhand_item {item:"minecraft:shield",customData:"{my_tag:1b}",invoke:"function mypack:on_shield"}
# ─────────────────────────────────────────────────────────────────

$execute as @a at @s if items entity @s weapon.offhand $(item)[minecraft:custom_data=$(customData)] run $(invoke)
