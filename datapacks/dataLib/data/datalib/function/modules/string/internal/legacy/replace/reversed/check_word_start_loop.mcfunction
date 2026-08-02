# Check if last character matches
data modify storage datalib:stringlib_data.temp data.LastChar set string storage datalib:stringlib_data.temp data.String -1
execute store success score #StringLib.SuccessCheck StringLib run data modify storage datalib:stringlib_data.temp data.LastChar set string storage datalib:stringlib_data.input replace.Find -1
execute if score #StringLib.SuccessCheck StringLib matches 0 if function datalib:modules/string/internal/legacy/replace/reversed/replace run return 0

# Next loop (Stop once the word can no longer fit, or if it's been found already)
execute if score #StringLib.Index StringLib matches 0 run return run scoreboard players set #StringLib.FoundNothing StringLib 1
scoreboard players remove #StringLib.Index StringLib 1
data modify storage datalib:stringlib_data.temp data.StringAfter prepend string storage datalib:stringlib_data.temp data.String -1
data modify storage datalib:stringlib_data.temp data.String set string storage datalib:stringlib_data.temp data.String 0 -1
function datalib:modules/string/internal/legacy/replace/reversed/check_word_start_loop
