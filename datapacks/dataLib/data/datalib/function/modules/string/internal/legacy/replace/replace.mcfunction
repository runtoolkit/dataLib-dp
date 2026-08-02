# Replace (FindLength > 1)
execute if score #StringLib.FindLength StringLib matches 2.. run return run function datalib:modules/string/internal/legacy/replace/check_word_rest

# Replace (FindLength = 1)
data modify storage datalib:stringlib_data.temp data.CheckString.String set from storage datalib:stringlib_data.temp data.String
data modify storage datalib:stringlib_data.input concat append from storage datalib:stringlib_data.temp data.StringBefore[]
data modify storage datalib:stringlib_data.input concat append from storage datalib:stringlib_data.input replace.Replace
data modify storage datalib:stringlib_data.temp data.StringBefore set value []
return run scoreboard players add #StringLib.ReturnValue StringLib 1
