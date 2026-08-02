data remove storage datalib:stringlib_data.temp data.StringList[-1]
data modify storage datalib:stringlib_data.temp data.S2 set from storage datalib:stringlib_data.temp data.StringList[-1]
data remove storage datalib:stringlib_data.temp data.StringList[-1]
data modify storage datalib:stringlib_data.temp data.S3 set from storage datalib:stringlib_data.temp data.StringList[-1]
function datalib:modules/string/_generated/concat_s/2c with storage datalib:stringlib_data.temp data
