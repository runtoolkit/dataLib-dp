# datalib:api/wand/internal/call_cmd [MACRO]

# SECURITY: central gate

tellraw @a[tag=datalib.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
