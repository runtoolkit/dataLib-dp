# Check if 'Find' is located at that position (Last character already matches) (IsFindLength is set to 0 because the 'store success' check here only stores the value if it's 1 because it has a command after it that might not run)
execute store result score #StringLib.CheckString.CharsLeft StringLib run data get storage datalib:stringlib_data.temp data.String
scoreboard players set #StringLib.CheckString.IsFindLength StringLib 0
execute store success score #StringLib.CheckString.IsFindLength StringLib if score #StringLib.FindLength StringLib <= #StringLib.CheckString.CharsLeft StringLib run scoreboard players operation #StringLib.CheckString.CharsLeft StringLib = #StringLib.FindLength StringLib
execute if score #StringLib.CheckString.IsFindLength StringLib matches 0 run return 0
scoreboard players remove #StringLib.CheckString.CharsLeft StringLib 1

data modify storage datalib:stringlib_data.temp data.CheckString.String set string storage datalib:stringlib_data.temp data.String 0 -1
data modify storage datalib:stringlib_data.temp data.CheckString.Find set string storage datalib:stringlib_data.input replace.Find 0 -1

function datalib:modules/string/internal/legacy/find/reversed/check_word_rest_loop
execute if score #StringLib.SuccessCheck StringLib matches 0 run return 0

# Replace (FindLength < -1) (Already in this function instead of running the other one to save some score checks)
data modify storage datalib:stringlib_data.input concat prepend from storage datalib:stringlib_data.temp data.StringAfter[]
data modify storage datalib:stringlib_data.input concat prepend from storage datalib:stringlib_data.input replace.Replace
data modify storage datalib:stringlib_data.temp data.StringAfter set value []
return run scoreboard players add #StringLib.ReturnValue StringLib 1
