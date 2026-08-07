# datalib:config
# Single source of runtime configuration (replaces _rt_origin + scattered defaults).
# Other packs may read datalib:engine config / datalib.meta scores; do not hardcode.

# ── Version (602 = 6.0.2) ──────────────────────────────────────────
scoreboard objectives add datalib.meta dummy
scoreboard players set #runtoolkit.packs.datalib.version datalib.meta 602

# Archived flag: set to 1 to show archive warning on every /reload
# scoreboard players set #runtoolkit.archivedpacks.datalib datalib.meta 1
execute unless score #runtoolkit.archivedpacks.datalib datalib.meta = #runtoolkit.archivedpacks.datalib datalib.meta run scoreboard players set #runtoolkit.archivedpacks.datalib datalib.meta 0

# ── Engine defaults (only fill missing keys — preserves live data) ─
execute unless data storage datalib:engine global run data modify storage datalib:engine global set value {}
data modify storage datalib:engine global.version set value "v6.0.2"

execute unless data storage datalib:engine config run data modify storage datalib:engine config set value {}

# Feature toggles (override via /data modify storage datalib:engine config.*)
execute unless data storage datalib:engine config.enabled run data modify storage datalib:engine config.enabled set value 1b
execute unless data storage datalib:engine config.debug_default run data modify storage datalib:engine config.debug_default set value 0b
execute unless data storage datalib:engine config.log_level run data modify storage datalib:engine config.log_level set value 1
execute unless data storage datalib:engine config.sandbox run data modify storage datalib:engine config.sandbox set value 1b
execute unless data storage datalib:engine config.reload_warn run data modify storage datalib:engine config.reload_warn set value 1b
execute unless data storage datalib:engine config.namespace_allowlist run data modify storage datalib:engine config.namespace_allowlist set value ["datalib:"]

# Mirror sandbox flag used by gate/* — gates are active by default (sandbox:1b).
# Disabling requires confirmation via dl_load:gate/toggle/disable; re-enabling
# (dl_load:gate/toggle/enable) does not.
execute if data storage datalib:engine config{sandbox:1b} run data modify storage datalib:engine sandbox set value 1b
execute unless data storage datalib:engine config{sandbox:1b} run data modify storage datalib:engine sandbox set value 0b

# Admin min level storage (legacy readers; not enforced when gates removed)
execute unless data storage datalib:engine security run data modify storage datalib:engine security set value {}
execute unless data storage datalib:engine security.admin_min_level run data modify storage datalib:engine security.admin_min_level set value 0
execute unless data storage datalib:engine security.cmd_min_level run data modify storage datalib:engine security.cmd_min_level set value 0
execute unless data storage datalib:engine security.sandbox_cmd_min_level run data modify storage datalib:engine security.sandbox_cmd_min_level set value 0
