# datalib:core/internal/api/wand/dispatch
# Called as @s. Compare held items with the bind list.

data modify storage datalib:engine _wand_iter set from storage datalib:engine wand_binds
execute if data storage datalib:engine _wand_iter[0] run function datalib:core/internal/api/wand/check_next
data remove storage datalib:engine _wand_iter
data remove storage datalib:engine _wand_current
