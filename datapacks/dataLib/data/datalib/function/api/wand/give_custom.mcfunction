# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/give_custom
# Gives a custom item tagged as a wand.
# Any item type can be used (sword, stick, etc.)
# but right-click only works with carrot_on_a_stick.
#
# INPUT:
#   $(player) → target player
#   $(tag)    → wand tag
#   $(name)   → item name (JSON text string)
#   $(count)  → quantity (default 1)
#
# EXAMPLE:
# data modify storage datalib:input player set value "Steve"
# data modify storage datalib:input tag set value "ice_wand"
# data modify storage datalib:input name set value "Ice Wand"
# data modify storage datalib:input count set value 1
# function datalib:api/wand/give_custom with storage datalib:input {}
# ─────────────────────────────────────────────────────────────────

$give @a[name=$(player),limit=1] minecraft:carrot_on_a_stick[minecraft:custom_data={wand:"$(tag)"},minecraft:item_name={"text":"$(name)"},minecraft:enchantment_glint_override=true] $(count)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/give_custom ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(item)","color":"aqua"},{"text":" [$(tag)]","color":"#555555"}]
