# datalib:systems/hook/on_killed_by_arrow
# Reward: killed_by_arrow advancement (entity_killed_player + killing_blow arrow)
advancement revoke @s only datalib:systems/hook/killed_by_arrow
scoreboard players add @s datalib.hook_killed_by_arrow 1
