# datalib:systems/hook/internal/run_cmd [MACRO]
# INPUT: $(cmd)
# @s = the triggering player

# SECURITY: central gate

execute if score #dl.log_level dl.log_level matches 4.. run tellraw @a[tag=datalib.debug] ["",{"text":"[Hook] ","color":"aqua"},{"selector":"@s","color":"gold"},{"text":" cmd executed","color":"#555555"}]
$$(cmd)
