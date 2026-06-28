# datalib:core/internal/api/gamerule/dispatch
execute if data storage datalib:input {value:"true"} if data storage datalib:input gr_on_true run return run function datalib:core/internal/api/gamerule/call_on_true with storage datalib:input {}
execute if data storage datalib:input {value:"false"} if data storage datalib:input gr_on_false run return run function datalib:core/internal/api/gamerule/call_on_false with storage datalib:input {}
execute if data storage datalib:input gr_on_value if data storage datalib:input gr_matches run function datalib:core/internal/api/gamerule/numeric_check with storage datalib:input {}
