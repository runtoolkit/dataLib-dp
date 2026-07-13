execute unless data storage datalib:engine _ia_ubinds[0] run return 0

data modify storage datalib:engine _ia_ucur set from storage datalib:engine _ia_ubinds[0]
data remove storage datalib:engine _ia_ubinds[0]

function datalib:core/internal/api/interaction/unbind_check with storage datalib:engine _ia_ufilter

function datalib:core/internal/api/interaction/unbind_filter
data remove storage datalib:engine _ia_ucur
