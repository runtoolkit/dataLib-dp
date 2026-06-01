# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/unregister
# Removes all wand binds belonging to a specific tag.
#
# INPUT (storage datalib:input):
# tag → wand tag to remove
#
# EXAMPLE:
# data modify storage datalib:input tag set value "fire_wand"
# function datalib:api/wand/unregister
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/api/wand/unregister_exec with storage datalib:engine {}
