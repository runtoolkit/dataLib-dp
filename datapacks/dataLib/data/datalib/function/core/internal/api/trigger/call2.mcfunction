# datalib:api/trigger/internal/call2 [MACRO]

# SECURITY: central gate
execute unless function datalib:core/security/cmd_gate run return 0

tellraw @a[tag=datalib.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
