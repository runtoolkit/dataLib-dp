##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Set the following data in the 'datalib:stringlib_data.input insert' data storage:                              ##
##    - String: Original string                                                                         ##
##    - Insertion: String you want to insert                                                            ##
##    - Index: Position for the Insertion                                                               ##
## 2. Run this function with the 'datalib:stringlib_data.input insert' data storage                                  ##
##                                                                                                      ##
## Output: A single combined string                                                                     ##
##         Example:                                                                                     ##
##                 - String: "Hello!"                                                                   ##
##                 - Insertion: " World"                                                                ##
##                 - Index: 5                                                                           ##
##                 => Output: "Hello World!"                                                            ##
##                                                                                                      ##
## The output is found in the 'datalib:stringlib_data.output insert' data storage                                    ##
##########################################################################################################

# Insert
$data modify storage datalib:stringlib_data.temp data.S1 set string storage datalib:stringlib_data.input insert.String 0 $(Index)
$data modify storage datalib:stringlib_data.temp data.S2 set string storage datalib:stringlib_data.input insert.String $(Index)
data modify storage datalib:stringlib_data.temp data.I set from storage datalib:stringlib_data.input insert.Insertion
function datalib:modules/string/internal/legacy/insert/main with storage datalib:stringlib_data.temp data
data remove storage datalib:stringlib_data.temp data