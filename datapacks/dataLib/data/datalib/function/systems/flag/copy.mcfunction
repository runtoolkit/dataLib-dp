# ─────────────────────────────────────────────────────────────────
# datalib:systems/flag/copy
# Copies a flag value from one key to another.
# If the source flag is set, the destination is set.
# If the source flag is absent, the destination is removed.
#  Input : $(from) → source flag key
#          $(to)   → destination flag key
# Output: datalib:output result → 1b if copied (flag was set), 0b if cleared
#
# Example:
# data modify storage datalib:input from set value "feature_a"
# data modify storage datalib:input to set value "feature_a_backup"
# function datalib:systems/flag/copy with storage datalib:input {}
# ─────────────────────────────────────────────────────────────────

# Default: clear destination
data modify storage datalib:output result set value 0b

$execute if data storage datalib:engine flags.$(from) run data modify storage datalib:engine flags.$(to) set value 1b
$execute if data storage datalib:engine flags.$(from) run data modify storage datalib:output result set value 1b
$execute unless data storage datalib:engine flags.$(from) run data remove storage datalib:engine flags.$(to)

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"flag/copy ","color":"aqua"},{"text":"$(from) → $(to) ","color":"gray"},{"storage":"datalib:output","nbt":"result","color":"green"}]
