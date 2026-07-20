$execute if data storage datalib:input {action:"disable"} run datapack disable $(pack)
$execute if data storage datalib:input {action:"enable"} run datapack enable $(pack)
$execute if data storage datalib:input {action:"list"} run function datalib:api/cmd/datapack_list
