function datalib:core/internal/events/uro_check with storage datalib:engine _uro.src[0]
data remove storage datalib:engine _uro.src[0]
execute if data storage datalib:engine _uro.src[0] run function datalib:core/internal/events/uro_loop
