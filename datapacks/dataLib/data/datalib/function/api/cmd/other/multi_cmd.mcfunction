# datalib:api/cmd/other/multi_cmd [MACRO]
# Executes a list of commands in order.
# INPUT (macro args): $(commands) — list of command strings/objects
#
# SECURITY: sets multiCommands.type = "multi_cmd" before run.
# Type is validated against security.multi_type_allowlist before execution.
# Invalid or unlisted types trigger type_violation (log + kick).

# Tag type — must be done before validation
data modify storage datalib:engine multiCommands.type set value "multi_cmd"
data modify storage datalib:engine multiCommands.active set value 1b

# Validate type
execute if data storage datalib:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage datalib:engine multiCommands.type
execute if data storage datalib:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage datalib:engine multiCommands.active
execute if data storage datalib:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run return run function datalib:core/security/multi_type_check

$data modify storage datalib:engine _mcmd_queue set value $(commands)
data modify storage datalib:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

execute at @s run function datalib:api/cmd/other/multi_cmd/run
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cmd/other/multi_cmd ","color":"aqua"},{"text":"▶ executing batch","color":"#555555"}]

# Clear type marker
data remove storage datalib:engine multiCommands.type
data remove storage datalib:engine multiCommands.active
