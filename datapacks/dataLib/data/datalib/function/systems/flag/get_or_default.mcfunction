# ─────────────────────────────────────────────────────────────────
# datalib:systems/flag/get_or_default
# Returns 1b if the flag is set, otherwise stores the given default.
#  Input : $(key)     → flag key
#          $(default) → value to store if flag is absent (0b or 1b)
#  Output: datalib:output result → 1b if set, $(default) if absent
#
# Example:
# data modify storage datalib:input key set value "my_feature"
# data modify storage datalib:input default set value 0b
# function datalib:systems/flag/get_or_default with storage datalib:input {}
# # datalib:output result = 0b (if flag not set)
# ─────────────────────────────────────────────────────────────────

$data modify storage datalib:output result set value $(default)
$execute if data storage datalib:engine flags.$(key) run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"flag/get_or_default ","color":"aqua"},{"text":"$(key) → ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
