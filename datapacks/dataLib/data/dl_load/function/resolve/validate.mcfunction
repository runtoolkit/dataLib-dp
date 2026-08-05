# validate — soft only
function datalib:config
execute unless data storage datalib:engine global run data modify storage datalib:engine global set value {version:"v6.0.2"}
