# dl_load:resolve/dependencies
# Resolves external/internal dependencies dataLib needs before the main
# load pipeline (dl_load:load/all) runs: origin watermark, fork status,
# and the optional StringLib companion pack.
#
# This does not abort the load on a missing StringLib — it is an
# optional dependency, so absence only produces a debug-tier warning.
# rt_origin / fork detection can open the fork confirmation gate via
# dl_load:core/internal/load/fork_warn, which is a warning tier too —
# only an explicit version mismatch (resolve/version) aborts load.

# ── Fork / origin detection ──────────────────────────────────────
# _rt_origin.mcfunction sets rt_origin_verified:1b at load time.
# Must run BEFORE the check below, otherwise the flag is never set yet
# on this pass (all.mcfunction calls _rt_origin AFTER validate) and the
# fork warning fires on every single load.
function datalib:_rt_origin
# Absence = file removed or pack is a modified fork.
# WARN only — load is not aborted, but admins are notified.
execute unless data storage datalib:engine global{rt_origin_verified:1b} run function dl_load:core/internal/load/fork_warn

# ── StringLib dependency (optional) ──────────────────────────────
execute unless score #StringLib.Init StringLib matches 1 run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"StringLib not initialized — datalib:core/lib/string/* unavailable","color":"yellow"}]

return 1
