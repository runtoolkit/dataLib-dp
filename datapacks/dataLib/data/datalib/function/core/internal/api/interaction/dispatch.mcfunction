data modify storage datalib:engine _ia_cur set from storage datalib:engine _ia_iter[0]
data remove storage datalib:engine _ia_iter[0]

function datalib:core/internal/api/interaction/check_bind with storage datalib:engine _ia_cur

execute if data storage datalib:engine _ia_iter[0] run function datalib:core/internal/api/interaction/dispatch
