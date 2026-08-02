# Check if first character matches
data modify storage datalib:stringlib_data.temp data.FirstChar set string storage datalib:stringlib_data.temp data.String 0 1
execute store success score #StringLib.SuccessCheck StringLib run data modify storage datalib:stringlib_data.temp data.FirstChar set string storage datalib:stringlib_data.input find.Find 0 1
execute if score #StringLib.SuccessCheck StringLib matches 0 if score #StringLib.FindLength StringLib matches 1 store result storage datalib:stringlib_data.output find[-1] int 1 run return run scoreboard players remove #StringLib.Index StringLib 1
execute if score #StringLib.SuccessCheck StringLib matches 0 if score #StringLib.FindLength StringLib matches 2.. if function datalib:modules/string/internal/legacy/find/check_word_rest store result storage datalib:stringlib_data.output find[-1] int 1 run return run scoreboard players remove #StringLib.Index StringLib 1

# Next loop (Stop once the word can no longer fit, or if it's been found already)
execute if score #StringLib.Index StringLib > #StringLib.CharsTotal StringLib run return run scoreboard players set #StringLib.FoundNothing StringLib 1
scoreboard players add #StringLib.Index StringLib 1
data modify storage datalib:stringlib_data.temp data.String set string storage datalib:stringlib_data.temp data.String 1
function datalib:modules/string/internal/legacy/find/check_word_start_loop
