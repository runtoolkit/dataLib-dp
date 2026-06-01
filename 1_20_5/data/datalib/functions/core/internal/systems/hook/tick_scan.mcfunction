# datalib:core/internal/systems/hook/tick_scan
# Her tick'te hook event'lerini tespit eder.
# Runs only if hook_binds is non-empty.

execute unless data storage datalib:engine hook_binds[0] run return 0

# player_join — datalib.hook_online score'u olmayan online oyuncu
# BUGFIX: existing players should not trigger after reload (scoreboards.mcfunction sets @a → 1)
execute as @a[scores={datalib.hook_online=..0}] run function datalib:core/internal/systems/hook/on_player_join
execute as @a run scoreboard players set @s datalib.hook_online 1

# player_death — detect deaths score increase
execute as @a[scores={datalib.hook_deaths=1..}] run function datalib:core/internal/systems/hook/on_player_death
execute as @a[scores={datalib.hook_deaths=1..}] run scoreboard players set @s datalib.hook_deaths 0

# player_respawn — was dead (dead flag set) but alive again
execute as @a[tag=datalib.hook_dead,nbt={DeathTime:0s}] run function datalib:core/internal/systems/hook/on_player_respawn
execute as @a[tag=datalib.hook_dead,nbt={DeathTime:0s}] run tag @s remove datalib.hook_dead
execute as @a[nbt={DeathTime:1s}] run tag @s add datalib.hook_dead

# level_up — XP level increase
execute as @a run function datalib:core/internal/systems/hook/check_level_up

# block_place — advancement-based, placed_blocks score increase
execute as @a[scores={datalib.hook_placed=1..}] run function datalib:core/internal/systems/hook/on_block_place
execute as @a[scores={datalib.hook_placed=1..}] run scoreboard players set @s datalib.hook_placed 0

# block_break — statistic-based (no advancement trigger in 1.20.3–26.1+)
execute as @a run function datalib:core/internal/systems/hook/check_block_break

# item_use — advancement-based, score increase
execute as @a[scores={datalib.hook_item_used=1..}] run function datalib:core/internal/systems/hook/on_item_use
execute as @a[scores={datalib.hook_item_used=1..}] run scoreboard players set @s datalib.hook_item_used 0


# entity_kill — advancement-based, score increase
execute as @a[scores={datalib.hook_entity_killed=1..}] run function datalib:core/internal/systems/hook/on_entity_kill
execute as @a[scores={datalib.hook_entity_killed=1..}] run scoreboard players set @s datalib.hook_entity_killed 0

# using_item — item_durability_changed advancement-based
execute as @a[scores={datalib.hook_using_item=1..}] run function datalib:core/internal/systems/hook/on_using_item
execute as @a[scores={datalib.hook_using_item=1..}] run scoreboard players set @s datalib.hook_using_item 0

# killed_by_arrow — entity_killed_player + killing_blow:arrow advancement-based
execute as @a[scores={datalib.hook_killed_by_arrow=1..}] run function datalib:core/internal/systems/hook/on_killed_by_arrow
execute as @a[scores={datalib.hook_killed_by_arrow=1..}] run scoreboard players set @s datalib.hook_killed_by_arrow 0

# hero_of_the_village — raid victory advancement-based
execute as @a[scores={datalib.hook_hero_of_the_village=1..}] run function datalib:core/internal/systems/hook/on_hero_of_the_village
execute as @a[scores={datalib.hook_hero_of_the_village=1..}] run scoreboard players set @s datalib.hook_hero_of_the_village 0

# sneak_start / sneak_stop — predicate-based
execute as @a[scores={datalib.hook_sneak=..0},predicate=datalib:is_sneaking] run function datalib:core/internal/systems/hook/on_sneak_start
execute as @a[scores={datalib.hook_sneak=1},predicate=!datalib:is_sneaking] run function datalib:core/internal/systems/hook/on_sneak_stop
execute as @a[predicate=datalib:is_sneaking] run scoreboard players set @s datalib.hook_sneak 1
execute as @a[predicate=!datalib:is_sneaking] run scoreboard players set @s datalib.hook_sneak 0

# sprint_start / sprint_stop — predicate-based
execute as @a[scores={datalib.hook_sprint=..0},predicate=datalib:is_sprinting] run function datalib:core/internal/systems/hook/on_sprint_start
execute as @a[scores={datalib.hook_sprint=1},predicate=!datalib:is_sprinting] run function datalib:core/internal/systems/hook/on_sprint_stop
execute as @a[predicate=datalib:is_sprinting] run scoreboard players set @s datalib.hook_sprint 1
execute as @a[predicate=!datalib:is_sprinting] run scoreboard players set @s datalib.hook_sprint 0

# elytra_start / elytra_stop — predicate-based
execute as @a[scores={datalib.hook_elytra=..0},predicate=datalib:is_gliding] run function datalib:core/internal/systems/hook/on_elytra_start
execute as @a[scores={datalib.hook_elytra=1},predicate=!datalib:is_gliding] run function datalib:core/internal/systems/hook/on_elytra_stop
execute as @a[predicate=datalib:is_gliding] run scoreboard players set @s datalib.hook_elytra 1
execute as @a[predicate=!datalib:is_gliding] run scoreboard players set @s datalib.hook_elytra 0


execute as @a[scores={datalib.hook_dim_changed=1..}] run function datalib:core/internal/systems/hook/on_dimension_change
execute as @a[scores={datalib.hook_dim_changed=1..}] run scoreboard players set @s datalib.hook_dim_changed 0

execute as @a[scores={datalib.hook_traded=1..}] run function datalib:core/internal/systems/hook/on_trade
execute as @a[scores={datalib.hook_traded=1..}] run scoreboard players set @s datalib.hook_traded 0

# jumped — minecraft.custom:minecraft.jump stat
execute as @a[scores={datalib.hook_jump=1..}] run function datalib:core/internal/systems/hook/on_jump
execute as @a[scores={datalib.hook_jump=1..}] run scoreboard players reset @s datalib.hook_jump

# open_chest — minecraft.custom:minecraft.open_chest stat
execute as @a[scores={datalib.hook_open_chest=1..}] run function datalib:core/internal/systems/hook/on_open_chest
execute as @a[scores={datalib.hook_open_chest=1..}] run scoreboard players reset @s datalib.hook_open_chest

# drop_item — minecraft.custom:minecraft.drop stat
execute as @a[scores={datalib.hook_drop=1..}] run function datalib:core/internal/systems/hook/on_drop
execute as @a[scores={datalib.hook_drop=1..}] run scoreboard players reset @s datalib.hook_drop

# target_hit — minecraft.custom:minecraft.target_hit stat
execute as @a[scores={datalib.hook_target_hit=1..}] run function datalib:core/internal/systems/hook/on_target_hit
execute as @a[scores={datalib.hook_target_hit=1..}] run scoreboard players reset @s datalib.hook_target_hit

# eat — consume_item advancement-based
execute as @a[scores={datalib.hook_eat=1..}] run function datalib:core/internal/systems/hook/on_eat_fire
execute as @a[scores={datalib.hook_eat=1..}] run scoreboard players set @s datalib.hook_eat 0

# fish_caught — fishing_rod_hooked advancement-based
execute as @a[scores={datalib.hook_fish=1..}] run function datalib:core/internal/systems/hook/on_fish_fire
execute as @a[scores={datalib.hook_fish=1..}] run scoreboard players set @s datalib.hook_fish 0
