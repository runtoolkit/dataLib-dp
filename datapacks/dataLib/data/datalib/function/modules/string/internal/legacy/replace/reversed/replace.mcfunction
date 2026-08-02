# Replace (FindLength > 1)
execute if score #StringLib.FindLength StringLib matches 2.. run return run function datalib:modules/string/internal/legacy/replace/reversed/check_word_rest

# Replace (FindLength = 1)
data modify storage datalib:stringlib_data.temp data.CheckString.String set from storage datalib:stringlib_data.temp data.String
data modify storage datalib:stringlib_data.input concat prepend from storage datalib:stringlib_data.temp data.StringAfter[]
data modify storage datalib:stringlib_data.input concat prepend from storage datalib:stringlib_data.input replace.Replace
data modify storage datalib:stringlib_data.temp data.StringAfter set value []
return run scoreboard players add #StringLib.ReturnValue StringLib 1
