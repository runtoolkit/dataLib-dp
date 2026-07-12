$execute as @a[scores={$(name)=1..}] run function datalib:core/internal/api/perm/trigger/player_dispatch with storage datalib:engine _pt_tick_ctx

$execute as @a run scoreboard players enable @s $(name)
