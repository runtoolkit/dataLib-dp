#> This function will run on datapack loading

# ── Presence flag ────────────────────────────────────────────────
# Lets dataLib (_rt_origin.mcfunction) detect that this override pack
# is present in the build, without a hard function-existence check
# (Minecraft has no reliable if-function-exists primitive). Reuses
# dataLib's own datalib.meta objective rather than declaring a new one.
scoreboard objectives add datalib.meta dummy
scoreboard players set #datalib_extensions.present datalib.meta 1