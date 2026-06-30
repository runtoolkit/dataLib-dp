scoreboard objectives add dl.tmp dummy
scoreboard objectives add datalib.time dummy
scoreboard objectives add datalib_menu trigger
scoreboard objectives add dl_run trigger
scoreboard objectives add dl_action trigger
scoreboard objectives add datalib.dialog_load dummy
scoreboard objectives add health health {"text":"❤","color":"red"}
scoreboard objectives add dl.pre_version dummy
scoreboard objectives add datalib.pid dummy
scoreboard objectives add dl.freeze_id dummy
scoreboard objectives add datalib.onlinePlayers dummy
scoreboard objectives add datalib_settingsBook trigger

# Lantern Load integration — pack version tracking
scoreboard objectives add load.status dummy



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

# Version calculation constants (for Lantern Load integration)
scoreboard players set #10000 dl.tmp 10000
scoreboard players set #100 dl.tmp 100

# Log level system: 0=off 1=error 2=warn 3=info 4=debug
scoreboard objectives add dl.log_level dummy
execute unless score #dl.log_level dl.log_level matches 0.. run scoreboard players set #dl.log_level dl.log_level 3

# Config scoreboard — fast integer config values (no storage lookup needed)
scoreboard objectives add datalib.config dummy

# Gamerule module — scratch scoreboard for numeric range checks
scoreboard objectives add dl.gamerule dummy

# State scoreboard — per-player state machine (0=idle 1=combat 2=menu ...)
scoreboard objectives add datalib.state dummy

# Security module — per-player permission level
# 0=no access (default)  1=basic  2=standard  3=elevated($$(cmd))  4=super
scoreboard objectives add dl.perm_level dummy

# dev_settings module — per-player book page cursor
scoreboard objectives add dl.dev_pg2 dummy