# datalib:config/load_cfg
#
# Load-gate config. Reviewed via PR + GitHub Actions (see CONTRIBUTING.md).
# Key naming: #runtoolkit.packs.datalib.config.load.<name>
# Storage: datalib.meta scoreboard.
#
# Idempotent — only fills a key if it is missing, never overwrites.

# --- load.timeout_seconds: auto-cancel delay for the load confirmation gate (default 300 = 5 minutes) ---
execute unless score #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta matches 1.. run scoreboard players set #runtoolkit.packs.datalib.config.load.timeout_seconds datalib.meta 300

# --- load.sandbox_enabled: 0=normal gate flow, 1=auto-confirm on load (default 0)
# Mirrors the legacy datalib:engine {sandbox:1b} storage flag for
# backward compatibility — both are checked in dl_load:load/confirm.
execute unless score #runtoolkit.packs.datalib.config.load.sandbox_enabled datalib.meta matches 0..1 run scoreboard players set #runtoolkit.packs.datalib.config.load.sandbox_enabled datalib.meta 0
