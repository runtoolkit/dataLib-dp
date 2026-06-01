# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/give_lore
# Writes the wand with lore to mainhand (item replace).
#
# INPUT (storage datalib:input):
# player → target player name
# tag → wand tag
# name → item name (string)
# lore → lore metni, TEK SATIR (string)
# color → lore color (e.g. "red", "gold", "gray")
#
# EXAMPLE:
# data modify storage datalib:input player set value "Steve"
# data modify storage datalib:input tag set value "fire_wand"
# data modify storage datalib:input name set value "Fire Wand"
# data modify storage datalib:input lore set value "Fire Damage: +20"
# data modify storage datalib:input color set value "red"
# function datalib:api/wand/give_lore
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/api/wand/give_lore_exec with storage datalib:engine {}
