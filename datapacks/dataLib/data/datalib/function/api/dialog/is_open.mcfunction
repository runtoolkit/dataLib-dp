# ─────────────────────────────────────────────────────────────────
# datalib:api/dialog/is_open
# Checks whether the executing player currently has a dialog open.
# Output: datalib:output result → 1b (open) or 0b (closed / not set)
#
# Example:
# execute as @a run function datalib:api/dialog/is_open
# # Then read datalib:output result per player context
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output result set value 0b
execute if entity @s[tag=datalib.dialog_opened] unless entity @s[tag=datalib.dialog_closed] run data modify storage datalib:output result set value 1b

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"dialog/is_open ","color":"aqua"},{"text":"→ ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
