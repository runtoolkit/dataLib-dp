data modify storage datalib:engine pb_obj set value "health"
data modify storage datalib:engine pb_max set value 20
data modify storage datalib:engine pb_label set value "Health"

execute if data storage datalib:input pb_obj run data modify storage datalib:engine pb_obj set from storage datalib:input pb_obj
execute if data storage datalib:input max run data modify storage datalib:engine pb_max set from storage datalib:input max
execute if data storage datalib:input label run data modify storage datalib:engine pb_label set from storage datalib:input label