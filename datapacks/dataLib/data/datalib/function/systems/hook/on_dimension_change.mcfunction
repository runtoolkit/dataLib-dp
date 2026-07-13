# datalib:systems/hook/on_dimension_change
# Advancement reward: runs when changed_dimension triggers.
# @s = player who changed dimension

advancement revoke @s only datalib:systems/hook/dimension_change
scoreboard players add @s datalib.hook_dim_changed 1
