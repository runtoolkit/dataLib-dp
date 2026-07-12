# ─────────────────────────────────────────────────────────────────
# datalib:world/entity/set_name
# Sets the display name (CustomName) on every entity matching the
# given tag. The name is read from datalib:input name — NOT passed
# as a macro argument — to avoid quote/apostrophe injection crashes
# and to support full JSON text components on all versions.
#
# INPUT : $(tag)              → entity tag to match
#         datalib:input name  → JSON text component (caller sets this
#                               before calling this function)
#
# CALLER PATTERN:
#   # Plain white text (works on all versions):
#   data modify storage datalib:input name set value '"Dragon King"'
#
#   # Colored component (works on all versions):
#   data modify storage datalib:input name set value '{"text":"Dragon King","color":"red"}'
#
#   function datalib:world/entity/set_name {tag:"myboss"}
#
# NOTE: data modify storage → CustomName works on all supported
#       versions without version-specific syntax differences.
# ─────────────────────────────────────────────────────────────────

$execute as @e[tag=$(tag)] run data modify entity @s CustomName set from storage datalib:input name
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"entity/set_name ","color":"aqua"},{"text":"[$(tag)]","color":"gray"},{"text":" ← datalib:input name","color":"#555555"}]
