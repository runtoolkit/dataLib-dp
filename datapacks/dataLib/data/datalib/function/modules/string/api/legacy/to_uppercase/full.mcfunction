##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Run this function with the 'String' macro variable set to what you want to convert to uppercase   ##
##    Note: This function will cover the entire unicode range of letters, but is also noticeably slower ##
##                                                                                                      ##
## Output: Uppercase version of your input                                                              ##
##         Example: "abc" => "ABC"                                                                      ##
##                                                                                                      ##
## The output is found in the 'datalib:stringlib_data.output to_uppercase' data storage                              ##
##########################################################################################################

# Setup
$data modify storage datalib:stringlib_data.temp data.Input set value "$(String)"
execute store result score #StringLib.CharsLeft StringLib run data get storage datalib:stringlib_data.temp data.Input
data modify storage datalib:stringlib_data.temp data.Char set string storage datalib:stringlib_data.temp data.Input 0 1

# Capitalize each character
function datalib:modules/string/internal/legacy/to_uppercase/main_full with storage datalib:stringlib_data.temp data

# Combine the characters again
data modify storage datalib:stringlib_data.temp data2.PrevInput set from storage datalib:stringlib_data.input concat
data modify storage datalib:stringlib_data.temp data2.PrevOutput set from storage datalib:stringlib_data.output concat

data modify storage datalib:stringlib_data.input concat set from storage datalib:stringlib_data.temp data.CharList
function datalib:modules/string/api/legacy/concat
data modify storage datalib:stringlib_data.output to_uppercase set from storage datalib:stringlib_data.output concat

data modify storage datalib:stringlib_data.input concat set from storage datalib:stringlib_data.temp data2.PrevInput
data modify storage datalib:stringlib_data.output concat set from storage datalib:stringlib_data.temp data2.PrevOutput
execute unless data storage datalib:stringlib_data.temp data2.PrevInput run data remove storage datalib:stringlib_data.input concat
execute unless data storage datalib:stringlib_data.temp data2.PrevOutput run data remove storage datalib:stringlib_data.output concat

# Reset
data remove storage datalib:stringlib_data.temp data2
