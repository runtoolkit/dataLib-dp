schedule clear datalib:core/lib/sync_tick

forceload remove -30000000 1600
forceload remove 0 0

scoreboard players reset @a dl_menu
scoreboard players reset @a datalib_run

scoreboard players reset $tick dl.tmp
scoreboard players reset $pq_depth dl.tmp
# $epoch intentionally preserved — cooldown expiry times depend on it

data remove storage datalib:engine queue
data remove storage datalib:engine events
data remove storage datalib:engine event_context
data remove storage datalib:engine _event_tmp
data remove storage datalib:engine cooldowns
data remove storage datalib:engine throttle
data remove storage datalib:engine players
data remove storage datalib:engine flags
data remove storage datalib:engine states
data remove storage datalib:engine schedules
data remove storage datalib:engine _input_stack
data remove storage datalib:engine _repeat
data remove storage datalib:engine _rng_state
data remove storage datalib:engine _felist_input
data remove storage datalib:engine _felist_state
data remove storage datalib:engine _felist_current
data remove storage datalib:engine _felist_i
data remove storage datalib:engine log_display
scoreboard players reset #dl.log_count dl.tmp
data remove storage datalib:engine trigger_binds
data remove storage datalib:engine _tc_binds
data remove storage datalib:engine _tc_current
data remove storage datalib:engine _tc_unbind
data remove storage datalib:engine _tc_uval
data remove storage datalib:engine interaction_binds
data remove storage datalib:engine _ia_iter
data remove storage datalib:engine _ia_cur
data remove storage datalib:engine _ia_ubinds
data remove storage datalib:engine _ia_ufilter
data remove storage datalib:engine _ia_ucur
data remove storage datalib:engine teams
data remove storage datalib:engine global
data remove storage datalib:output result

# rate_limit module cleanup
data remove storage datalib:engine rate_limit

scoreboard objectives remove dl.tmp
scoreboard objectives remove datalib.time
scoreboard objectives remove dl_menu
scoreboard objectives remove datalib_run
scoreboard objectives remove datalib_action
scoreboard objectives remove datalib.tick_guard
scoreboard objectives remove datalib.dialog_load
scoreboard objectives remove health
scoreboard objectives remove dl.pre_version

scoreboard objectives remove datalib.Flags
scoreboard objectives remove datalib.hook_eat
scoreboard objectives remove datalib.hook_fish
scoreboard objectives remove datalib.state

tag @a remove datalib.dialog_opened
tag @a remove datalib.dialog_closed
advancement revoke @a from datalib:hidden/root

scoreboard objectives remove datalib.pid
scoreboard objectives remove datalib.rightClick
data remove storage datalib:engine wand_binds
data remove storage datalib:engine _wand_iter
data remove storage datalib:engine _wand_current
data remove storage datalib:engine _wand_unbinds
data remove storage datalib:engine _wand_filter_tag
data remove storage datalib:engine _wand_cur
data remove storage datalib:engine player_pids
data remove storage datalib:engine _pid_seq

# Hook module cleanup
scoreboard objectives remove datalib.hook_online
scoreboard objectives remove datalib.hook_deaths
scoreboard objectives remove datalib.hook_placed
scoreboard objectives remove datalib.hook_lvl
scoreboard objectives remove datalib.hook_lvl_new
scoreboard objectives remove datalib.hook_sneak
scoreboard objectives remove datalib.hook_sprint
scoreboard objectives remove datalib.hook_elytra
tag @a remove datalib.hook_dead
tag @a remove datalib.hook_sneaking
tag @a remove datalib.hook_sprinting
tag @a remove datalib.hook_gliding
scoreboard objectives remove datalib.hook_tool_used
scoreboard objectives remove datalib.hook_item_used
scoreboard objectives remove datalib.hook_entity_killed
scoreboard objectives remove datalib.hook_using_item
scoreboard objectives remove datalib.hook_killed_by_arrow
scoreboard objectives remove datalib.hook_hero_of_the_village
data remove storage datalib:engine hook_binds
data remove storage datalib:engine _hook_iter
data remove storage datalib:engine _hook_ctx
data remove storage datalib:engine _hook_fire_event
data remove storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_unbinds
data remove storage datalib:engine _hook_filter_event

# Fiber module cleanup
data remove storage datalib:engine fibers

# Region watch cleanup
data remove storage datalib:engine region_watches

# Batch module cleanup
data remove storage datalib:engine batches

# Once-per-player cleanup
data remove storage datalib:engine once_per_player

# UUID cache cleanup
data remove storage datalib:engine _uuid_cache
