##################################################################################
##                                  HOW TO USE                                  ##
##################################################################################
## 1. Set the following data in the 'datalib:stringlib_data.input split' data storage:       ##
##    - String: Original string                                                 ##
##    - Separator: String that splits the original into multiple                ##
##        - Default: " "                                                        ##
##        - "": Split each character                                            ##
##    - n: Up until which instance of the separator it should split             ##
##        - Unset or 0: All                                                     ##
##        - Positive: First n                                                   ##
##        - Negative: Last -n                                                   ##
##    - KeepEmpty: Boolean for whether to keep empty Strings in the output list ##
##        - Unset or 0b: Remove                                                 ##
##        - 1b: Keep                                                            ##
##                                                                              ##
## 2. Run this function                                                         ##
##                                                                              ##
## Output: List of Strings, separated by the Separator                          ##
##         Example:                                                             ##
##                 - String: "Hello World!"                                     ##
##                 - Separator: " "                                             ##
##                 - n: 1                                                       ##
##                 - KeepEmpty: Unset                                           ##
##                 => Output: ["Hello", "World!"]                               ##
##                                                                              ##
##                 - String: "Test! HelloTestWorld!"                            ##
##                 - Separator: "Test"                                          ##
##                 - n: -1                                                      ##
##                 - KeepEmpty: Unset                                           ##
##                 => Output: ["Test! Hello", "World!"]                         ##
##                                                                              ##
##                 - String: " Hello    World! "                                ##
##                 - Separator: " "                                             ##
##                 - n: Unset                                                   ##
##                 - KeepEmpty: 1b                                              ##
##                 => Output: ["", "Hello", "", "", "", "World!", ""]           ##
##                                                                              ##
##                                                                              ##
## Return value: Number of elements in the output list, or fail                 ##
##                                                                              ##
## The output is found in the 'datalib:stringlib_data.output split' data storage             ##
##################################################################################
# Potential optimization: Detect if the current instance of the seperator came DIRECTLY after the previous one. If yes, and if KeepEmpty is 0b, ignore it and don't run the macro
# => It's probably best to set up a recursive loop that continues the loop from main, but skips everything for as long as the separators are after each other. So it checks if the *next* one is directly after the current one
# ALSO OPTIMIZE THE "SPLIT EVERY CHARACTER". CAN BE HEAVILY OPTIMIZED TO PREVENT LOOPING

# Setup
data modify storage datalib:stringlib_data.output split set value []
execute unless data storage datalib:stringlib_data.input split.Separator run data modify storage datalib:stringlib_data.temp data.Separator set value " "
data modify storage datalib:stringlib_data.temp data.Separator set from storage datalib:stringlib_data.input split.Separator

    # Reset temporary storage & return fail if input string is empty
execute store result score #StringLib.SeparatorLength StringLib run data get storage datalib:stringlib_data.temp data.Separator
execute store result score #StringLib.CharsTotal StringLib run data get storage datalib:stringlib_data.input split.String
execute if score #StringLib.CharsTotal StringLib matches 0 run data modify storage datalib:stringlib_data.output split set value [""]
execute if score #StringLib.CharsTotal StringLib matches 0 run data remove storage datalib:stringlib_data.temp data
execute if score #StringLib.CharsTotal StringLib matches 0 run return fail

# If separator is empty string, split each character
execute if score #StringLib.SeparatorLength StringLib matches 0 run return run function datalib:modules/string/internal/legacy/split/split_chars/setup

# Find all instances of the separator
data modify storage datalib:stringlib_data.temp data2.PrevInput set from storage datalib:stringlib_data.input find
data modify storage datalib:stringlib_data.temp data2.PrevOutput set from storage datalib:stringlib_data.output find

data modify storage datalib:stringlib_data.input find.String set from storage datalib:stringlib_data.input split.String
data modify storage datalib:stringlib_data.input find.Find set from storage datalib:stringlib_data.temp data.Separator
data remove storage datalib:stringlib_data.input find.n
data modify storage datalib:stringlib_data.input find.n set from storage datalib:stringlib_data.input split.n
function datalib:modules/string/api/legacy/find

# Setup
execute store result score #StringLib.KeepEmpty StringLib run data get storage datalib:stringlib_data.input split.KeepEmpty

    # Reset temporary storage & return fail if no separator was found
execute if data storage datalib:stringlib_data.output {find:[-1]} run return run function datalib:modules/string/internal/legacy/split/fail

# Split
execute store result score #StringLib.FindAmount StringLib run data get storage datalib:stringlib_data.input split.n

    # Split the part in front of every instance of the separator (Do the first iteration here)
execute store result score #StringLib.SplitsLeft StringLib if data storage datalib:stringlib_data.output find[]

data modify storage datalib:stringlib_data.temp data.Min set value 0
execute if score #StringLib.FindLength StringLib matches 0.. store result storage datalib:stringlib_data.temp data.Max int 1 store result score #StringLib.Max StringLib run data get storage datalib:stringlib_data.output find[0]
execute if score #StringLib.FindLength StringLib matches 0.. run function datalib:modules/string/internal/legacy/split/main with storage datalib:stringlib_data.temp data
execute if score #StringLib.FindLength StringLib matches ..-1 store result storage datalib:stringlib_data.temp data.Max int 1 store result score #StringLib.Max StringLib run data get storage datalib:stringlib_data.output find[-1]
execute if score #StringLib.FindLength StringLib matches ..-1 run function datalib:modules/string/internal/legacy/split/reversed/main with storage datalib:stringlib_data.temp data

    # Append a "" if KeepEmpty is 1b and there's a trailing separator
execute store result storage datalib:stringlib_data.temp data.Min int 1 run scoreboard players operation #StringLib.Max StringLib += #StringLib.SeparatorLength StringLib
execute if score #StringLib.KeepEmpty StringLib matches 1 if score #StringLib.Max StringLib = #StringLib.CharsTotal StringLib run data modify storage datalib:stringlib_data.output split append value ""

    # Append the part after the last separator
execute unless score #StringLib.Max StringLib = #StringLib.CharsTotal StringLib run function datalib:modules/string/internal/legacy/split/last_segment with storage datalib:stringlib_data.temp data

function datalib:modules/string/internal/legacy/split/setup with storage datalib:stringlib_data.temp data

# Reset
data modify storage datalib:stringlib_data.input find set from storage datalib:stringlib_data.temp data2.PrevInput
data modify storage datalib:stringlib_data.output find set from storage datalib:stringlib_data.temp data2.PrevOutput
execute unless data storage datalib:stringlib_data.temp data2.PrevInput run data remove storage datalib:stringlib_data.input find
execute unless data storage datalib:stringlib_data.temp data2.PrevOutput run data remove storage datalib:stringlib_data.output find
data remove storage datalib:stringlib_data.temp data2
data remove storage datalib:stringlib_data.temp data

# Return Values
return run execute if data storage datalib:stringlib_data.output split[]