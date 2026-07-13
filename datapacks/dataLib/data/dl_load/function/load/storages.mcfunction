# dl_load:load/storages
# Initializes datalib:engine storage fields that do not yet exist.
#
# SAFETY DESIGN
# -------------
# EVERY write here uses 'execute unless data storage ...' guards.
# This means:
#   - Fields that already exist from a prior session are NOT overwritten.
#   - Only fields missing from storage are initialized.
#   - Nondeterministic overwrite behaviour is impossible in this file.
#
# Fields that are INTENTIONALLY cleared on each reload are listed with
# explicit comments explaining why.
#
# SCOREBOARD SAFETY
# -----------------
# Epoch is preserved across reloads — cooldown expiry times depend on it.
# Tick counter is reset (irrelevant across reloads — just a monotonic counter).
# pq_depth is reset (queue state cannot survive reload safely).
#
# STORAGE VERSION GUARD
# ---------------------
# validate.mcfunction blocks a second load if global{loaded:1b} is set,
# so we only reach here when storage is either:
#   (a) fresh / never initialized, or
#   (b) was cleanly disabled via datalib:disable (cleanup removed global).
# In both cases, initializing with 'unless data' guards is safe.

execute unless score $epoch datalib.time matches -2147483648..2147483647 run scoreboard players set $epoch datalib.time 0
scoreboard players set $tick dl.tmp 0

scoreboard players set $pq_depth dl.tmp 0

scoreboard players set $pb_four dl.tmp 1

execute unless data storage datalib:engine throttle run data modify storage datalib:engine throttle set value {}

execute unless data storage datalib:engine flags run data modify storage datalib:engine flags set value {}
execute unless data storage datalib:engine states run data modify storage datalib:engine states set value {}

execute unless data storage datalib:engine permissions run data modify storage datalib:engine permissions set value {}

execute unless data storage datalib:engine perm_triggers run data modify storage datalib:engine perm_triggers set value {}
execute unless data storage datalib:engine perm_trigger_names run data modify storage datalib:engine perm_trigger_names set value []

execute unless data storage datalib:engine trigger_binds run data modify storage datalib:engine trigger_binds set value []

execute unless data storage datalib:engine interaction_binds run data modify storage datalib:engine interaction_binds set value {attack:[], use:[]}

execute unless data storage datalib:engine player_pids run data modify storage datalib:engine player_pids set value {}
execute unless data storage datalib:engine _pid_seq run data modify storage datalib:engine _pid_seq set value 0

# UUID module init
function datalib:core/internal/systems/uuid/init

# once_per_player module init
execute unless data storage datalib:engine once_per_player run data modify storage datalib:engine once_per_player set value {}

# Wand module init
execute unless data storage datalib:engine wand_binds run data modify storage datalib:engine wand_binds set value []

# Hook module init
execute unless data storage datalib:engine hook_binds run data modify storage datalib:engine hook_binds set value []

# lib/fiber module init
# BUGFIX: same issue as the queue note below — fibers was only ever
# cleared in cleanup.mcfunction (disable-only path, never /reload).
# A fiber record left over from before a reload would be orphaned now
# that queue is cleared below (nothing will ever resume it again), but
# clearing it explicitly here keeps the storage clean and matches what
# cleanup.mcfunction already does for the disable path.
data remove storage datalib:engine fibers
data modify storage datalib:engine fibers set value {}
# NOTE: fibers._pending no longer exists as of the resume_dispatch
# concurrency fix — resume targets now travel inside each queue entry
# (id/resume fields) instead of a separate shared FIFO list.

# core/lib/process_queue module init
# BUGFIX: the header comment above ("pq_depth is reset — queue state
# cannot survive reload safely") describes intent that was never
# actually implemented. queue is only ever cleared in
# core/internal/load/cleanup.mcfunction, which is exclusively called
# from datalib:disable — never from the /reload path (load/all.mcfunction
# does not call it). A queue entry left over from before a reload (e.g.
# a fiber resume, a delayed function/command) would silently keep
# running against whatever state exists after the reload, including
# referencing fiber ids or functions that no longer exist. Clearing it
# here actually fulfills what the comment above already claimed was
# happening.
data remove storage datalib:engine queue

# geo/region_watch module init
# Region watches are always cleared on reload — all packs must re-register
# their watches in the #datalib:init function tag. This is intentional:
# region watch registrations are transient and pack-owned.
data remove storage datalib:engine region_watches
data modify storage datalib:engine region_watches set value []

# lib/batch module init
# Incomplete batches are always cleared on reload — they cannot be safely
# resumed across a reload boundary (executing context is gone).
data remove storage datalib:engine batches
data modify storage datalib:engine batches set value {}

# Wand cooldown module — separate storage (avoids collision with datalib:cooldown)
execute unless data storage datalib:engine wand_cooldowns run data modify storage datalib:engine wand_cooldowns set value {}

# ─────────────────────────────────────────────────────────────────
# Security module init (v6.0.1-pre1+)
# BREAKING CHANGE: trust_players defaults to 0b — players must have
# dl.perm_level explicitly set. datalib.admin tag alone gives no access.
#
# Fields (all preserved across reloads via 'unless data' guards):
#   trust_players         0b = players not trusted (default, breaking)
#   cmd_min_level         min dl.perm_level to trigger $$(cmd) [3]
#   sandbox_cmd_min_level stricter $$(cmd) floor when sandbox:1b [4]
#   admin_min_level       min level for cmd/ functions (check_all) [2]
#   admin_can_override    0b = admins cannot bypass security rules
#   sandbox_allowlist     list of allowed command prefixes in sandbox []
# ─────────────────────────────────────────────────────────────────
execute unless data storage datalib:engine security run data modify storage datalib:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
# ─────────────────────────────────────────────────────────────────
# Security module v6.0.1-pre1+ additions
# BREAKING CHANGE: sandbox_allowlist is now a compound {} (was list []).
# Empty compound {} = all sandbox commands blocked.
# multi_type_allowlist: compound of permitted multiCommands.type values.
# multiCommands: tracks active multi-command execution context.
# ─────────────────────────────────────────────────────────────────
# Reset security to new compound format (migration: [] → {})
execute if data storage datalib:engine security.sandbox_allowlist[] run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security run data modify storage datalib:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
execute unless data storage datalib:engine security.sandbox_allowlist run data modify storage datalib:engine security.sandbox_allowlist set value {}
execute unless data storage datalib:engine security.multi_type_allowlist run data modify storage datalib:engine security.multi_type_allowlist set value {multi_cmd:1b,multi_cmd_adv:1b}

# multiCommands context tracker (always reset on load — transient state)
data remove storage datalib:engine multiCommands
data modify storage datalib:engine multiCommands set value {type:"",active:0b}

# ─────────────────────────────────────────────────────────────────
# Module toggle init (datalib:api/toggle)
# Each module defaults to enabled (1b) on first load.
# Preserved across reloads via 'unless data' guards — admin toggles survive /reload.
# Disable a module:  /function datalib:api/toggle/<name>/false
# Enable a module:   /function datalib:api/toggle/<name>/true
# List module states: /function datalib:api/toggle/list
# ─────────────────────────────────────────────────────────────────
execute unless data storage datalib:engine modules.hook run data modify storage datalib:engine modules.hook set value 1b
execute unless data storage datalib:engine modules.interaction run data modify storage datalib:engine modules.interaction set value 1b
execute unless data storage datalib:engine modules.perm run data modify storage datalib:engine modules.perm set value 1b
execute unless data storage datalib:engine modules.wand run data modify storage datalib:engine modules.wand set value 1b
execute unless data storage datalib:engine modules.geo run data modify storage datalib:engine modules.geo set value 1b

# ─────────────────────────────────────────────────────────────────
# cb module init
# cb_queue is always cleared on reload — in-flight delayed commands
# cannot be safely resumed across a reload boundary.
# ─────────────────────────────────────────────────────────────────
data remove storage datalib:engine cb_queue
data modify storage datalib:engine cb_queue set value []
data remove storage datalib:engine _cb_last
data remove storage datalib:engine _cb_work
data remove storage datalib:engine _cb_entry
execute unless data storage datalib:engine modules.cb run data modify storage datalib:engine modules.cb set value 1b

# ─────────────────────────────────────────────────────────────────
# Color API init
# Populates named color lookup table and initializes color namespace.
# palette and gradients are preserved across reloads (unless data guards).
# ─────────────────────────────────────────────────────────────────
function datalib:systems/color/init
