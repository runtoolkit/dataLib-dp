# dl_load:load/internal/fork_warn
# Called when rt_origin_verified is absent at load time.
# Indicates _rt_origin.mcfunction was removed or pack is a modified fork.
# Load continues — this is a WARNING, not a hard block.
#
# Notification tiers:
#   1. datalib.debug tag    → full technical detail
#   2. @a[tag=datalib.admin] → admin-level alert with action guidance
#   3. datalib:engine fork_warn → persistent flag for runtime checks

# ── Persistent flag ──────────────────────────────────────────────
data modify storage datalib:engine fork_warn set value 1b
data modify storage datalib:engine fork_warn_tick set value 0

# ── Sound ────────────────────────────────────────────────────────
playsound datalib:ui.warn master @a ~ ~ ~ 0.5 0.9

# ── Debug tier — full technical context ──────────────────────────
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ FORK ","color":"yellow","bold":true},{"text":"rt_origin_verified missing","color":"yellow"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"     cause  ","color":"#555555"},{"text":"_rt_origin.mcfunction removed or overwritten","color":"#FFAA00"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"     action ","color":"#555555"},{"text":"Verify pack integrity. Compare against upstream.","color":"gray"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"     flag   ","color":"#555555"},{"text":"datalib:engine fork_warn = 1b","color":"gray","italic":true}]

# ── Admin tier — actionable alert with links ──────────────────────
tellraw @a[tag=datalib.admin] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ Fork Warning","color":"yellow","bold":true}]
tellraw @a[tag=datalib.admin] ["",{"text":"     ","color":"#555555"},{"text":"This dataLib copy could not verify its origin.","color":"#FFCC00"}]
tellraw @a[tag=datalib.admin] ["",{"text":"     ","color":"#555555"},{"text":"_rt_origin.mcfunction is missing or was altered.","color":"#FFCC00"}]
tellraw @a[tag=datalib.admin] ["",{"text":"     ","color":"#555555"},{"text":"Load continues","color":"gray"},{"text":" — check pack integrity before trusting this build.","color":"#555555"}]
tellraw @a[tag=datalib.admin] ["",{"text":"     ","color":"#555555"},{"text":"[view upstream]","color":"aqua","underlined":true,"click_event":{"action":"open_url","url":"https://github.com/runtoolkit/dataLib-dp"}},{"text":"  ","color":"#555555"},{"text":"[releases]","color":"gold","underlined":true,"click_event":{"action":"open_url","url":"https://github.com/runtoolkit/dataLib-dp/releases"}},{"text":"  ","color":"#555555"},{"text":"[issues]","color":"yellow","underlined":true,"click_event":{"action":"open_url","url":"https://github.com/runtoolkit/dataLib-dp/issues"}}]

# ── Log system entry ──────────────────────────────────────────────
data modify storage datalib:engine _log_warn_tmp set value {message:"[Load] fork_warn — rt_origin_verified not set, possible modified fork"}
function datalib:systems/log/warn with storage datalib:engine _log_warn_tmp
