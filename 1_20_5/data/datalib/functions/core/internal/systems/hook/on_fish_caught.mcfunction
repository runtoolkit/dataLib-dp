# datalib:core/internal/systems/hook/on_fish_caught
# @s = the fishing player
scoreboard players add @s datalib.hook_fish 1
advancement revoke @s only datalib:systems/hook/fish_caught
