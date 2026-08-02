############################################################################
##                               HOW TO USE                               ##
############################################################################
## 1. Set the 'datalib:stringlib_data.input concat' data storage to a list of strings  ##
## 2. Run this function                                                   ##
##                                                                        ##
## Output: A single combined string                                       ##
##         Example: ["hello","world"] => "helloworld"                     ##
##                                                                        ##
## Return value: 1 if concat was successful, fail if it wasn't            ##
##                                                                        ##
## The output is found in the 'datalib:stringlib_data.output concat' data storage      ##
############################################################################

# Setup (Get how many times it needs to concatenate & prepare the starting string)
execute store result score #StringLib.StringsTotal StringLib if data storage datalib:stringlib_data.input concat[]
execute if score #StringLib.StringsTotal StringLib matches 3.. run return run function datalib:modules/string/internal/legacy/concat/main
execute unless score #StringLib.StringsTotal StringLib matches 2 run return fail

# Only 2 strings: Combine
data modify storage datalib:stringlib_data.temp data.S1 set from storage datalib:stringlib_data.input concat[1]
data modify storage datalib:stringlib_data.temp data.S2 set from storage datalib:stringlib_data.input concat[0]
function datalib:modules/string/internal/legacy/concat/combine_small with storage datalib:stringlib_data.temp data
data remove storage datalib:stringlib_data.temp data
return 1