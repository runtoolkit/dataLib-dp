# datalib:core/internal/systems/hook/on_eat
# @s = yiyen oyuncu
scoreboard players add @s datalib.hook_eat 1
advancement revoke @s only datalib:systems/hook/eat_food
