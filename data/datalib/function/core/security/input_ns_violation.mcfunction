# datalib:core/security/input_ns_violation
# Fired when func does not start with datalib:api/ (namespace violation).

data modify storage datalib:input message set value "[Security] input_ns_violation — func outside datalib:api/* namespace"
data modify storage datalib:input level set value "ERROR"
data modify storage datalib:input color set value "red"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:input {}
data remove storage datalib:input message
data remove storage datalib:input level
data remove storage datalib:input color

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security: function call outside permitted namespace (datalib:api/*).","color":"red"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"NS VIOLATION ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — func not in datalib:api/*","color":"red"}]
