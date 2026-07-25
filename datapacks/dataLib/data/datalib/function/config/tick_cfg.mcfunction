# datalib:config/tick_cfg
#
# Tick config system. No macros used (see CONTRIBUTING.md - tick config
# changes are reviewed via PR and checked by GitHub Actions; runtime macro
# key generation is not allowed here).
#
# Key naming: #runtoolkit.packs.datalib.config.tick.<name>
# Storage: datalib.meta scoreboard (config/gate values only - temporary data
#          uses dl.tmp, see dl_load:loader/scoreboards lines 5-6)
#
# This function only sets a default for keys that are MISSING; it does not
# overwrite an existing value (idempotent - safe to call again on reload).

# --- tick.rate: how many ticks between dispatch runs (default 1 = every tick) ---
execute unless score #runtoolkit.packs.datalib.config.tick.rate datalib.meta matches -2147483648..2147483647 run scoreboard players set #runtoolkit.packs.datalib.config.tick.rate datalib.meta 1

# --- tick.pause: 0 = running, 1 = paused (config-level flag, separate from the paused check in core/tick.mcfunction) ---
execute unless score #runtoolkit.packs.datalib.config.tick.pause datalib.meta matches -2147483648..2147483647 run scoreboard players set #runtoolkit.packs.datalib.config.tick.pause datalib.meta 0

# --- tick.max_channels: upper bound on simultaneously active channels ---
execute unless score #runtoolkit.packs.datalib.config.tick.max_channels datalib.meta matches -2147483648..2147483647 run scoreboard players set #runtoolkit.packs.datalib.config.tick.max_channels datalib.meta 32
