# dl_load:loader/scoreboards
# (moved from dl_load:load/scoreboards in v6.0.2 — load/ vs loader/
#  separates gate/confirmation logic from the actual init routines)

scoreboard objectives add dl.tmp dummy
scoreboard objectives add datalib.meta dummy
scoreboard objectives add datalib.time dummy
scoreboard objectives add dl_menu trigger
scoreboard objectives add dl_run trigger
scoreboard objectives add dl_action trigger
scoreboard objectives add datalib.dialog_load dummy
scoreboard objectives add dl.pre_version dummy
scoreboard objectives add datalib.pid dummy
scoreboard objectives add dl.freeze_id dummy
scoreboard objectives add datalib.onlinePlayers dummy

# Wand module — carrot_on_a_stick right-click tracker
scoreboard objectives add datalib.rightClick minecraft.used:minecraft.carrot_on_a_stick

# Hook module scoreboards
scoreboard objectives add datalib.hook_online dummy
# BUGFIX: existing players should not re-trigger as new joins after reload
scoreboard players set @a datalib.hook_online 1
scoreboard objectives add datalib.hook_deaths deathCount
# NOTE: placed_blocks is not a general statistic — must be used as dummy
scoreboard objectives add datalib.hook_placed dummy
scoreboard objectives add datalib.hook_lvl dummy
scoreboard objectives add datalib.hook_lvl_new dummy
# New hook scoreboards
scoreboard objectives add datalib.hook_sneak dummy
scoreboard objectives add datalib.hook_sprint dummy
scoreboard objectives add datalib.hook_elytra dummy
# block_break — item_durability_changed advancement-based
scoreboard objectives add datalib.hook_tool_used dummy
# item_use, entity_kill advancement-based
scoreboard objectives add datalib.hook_item_used dummy
scoreboard objectives add datalib.hook_entity_killed dummy
# using_item, killed_by_arrow, hero_of_the_village
scoreboard objectives add datalib.hook_using_item dummy
scoreboard objectives add datalib.hook_killed_by_arrow dummy
scoreboard objectives add datalib.hook_hero_of_the_village dummy

# geo/region_watch — no scoreboard needed for enter/leave tracking (uses entity tags)

# hook/dimension_change — changed_dimension advancement-based
scoreboard objectives add datalib.hook_dim_changed dummy

# hook/trade — villager_trade advancement-based
scoreboard objectives add datalib.hook_traded dummy

# Tick channel dispatch
scoreboard objectives add datalib.tick dummy
scoreboard objectives add datalib.Flags dummy

# Player stat hooks
scoreboard objectives add datalib.hook_jump minecraft.custom:minecraft.jump
scoreboard objectives add datalib.hook_open_chest minecraft.custom:minecraft.open_chest
scoreboard objectives add datalib.hook_drop minecraft.custom:minecraft.drop
scoreboard objectives add datalib.hook_target_hit minecraft.custom:minecraft.target_hit

# hook/eat — consume_item advancement-based
scoreboard objectives add datalib.hook_eat dummy
# hook/fish_caught — fishing_rod_hooked advancement-based
scoreboard objectives add datalib.hook_fish dummy

# input/validate module — scratch scores, all on the existing dl.tmp
# objective rather than a new one (DL.Len, DL.DotHits, etc. all live here)

# Log level system: 0=off 1=error 2=warn 3=info 4=debug
scoreboard objectives add dl.log_level dummy
execute unless score #dl.log_level dl.log_level matches 0.. run scoreboard players set #dl.log_level dl.log_level 3

# Config scoreboard — fast integer config values (no storage lookup needed)
scoreboard objectives add datalib.config dummy

# Gamerule module — scratch scoreboard for numeric range checks
scoreboard objectives add dl.gamerule dummy

# State scoreboard — per-player state machine (0=idle 1=combat 2=menu ...)
scoreboard objectives add datalib.state dummy
