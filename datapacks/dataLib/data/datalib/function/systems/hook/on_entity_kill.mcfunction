# datalib:systems/hook/on_entity_kill
# Reward: entity_kill advancement (player_killed_entity trigger)
advancement revoke @s only datalib:systems/hook/entity_kill
scoreboard players add @s datalib.hook_entity_killed 1
