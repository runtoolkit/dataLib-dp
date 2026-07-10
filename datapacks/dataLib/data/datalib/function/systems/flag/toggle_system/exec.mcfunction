# [MACRO] Internal exec for flag/toggle_system
$execute if data storage datalib:tick_work _ftgl{enabled:1b} run function datalib:core/tick/channel/disable {id:"$(id)"}
$execute if data storage datalib:tick_work _ftgl{enabled:0b} run function datalib:core/tick/channel/enable {id:"$(id)"}
