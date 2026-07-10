# datalib:systems/hook/internal/on_eat
# @s = the eating player
scoreboard players add @s datalib.hook_eat 1
advancement revoke @s only datalib:systems/hook/eat_food
