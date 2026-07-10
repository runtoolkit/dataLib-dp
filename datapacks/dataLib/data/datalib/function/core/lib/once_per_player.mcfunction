# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/once_per_player
# Runs the function once per player for the given key.
# Will not run again until the session is reset.
#  Input : $(func)   → function to run
#           $(key)    → unique key (e.g. "tutorial_intro")
#           $(player) → player name
# Output: datalib:output ran → 1b (ran) / 0b (already done)
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output ran set value 0b

$execute if data storage datalib:engine once_per_player.$(player).$(key) run return 0

data modify storage datalib:output ran set value 1b
$data modify storage datalib:engine once_per_player.$(player).$(key) set value 1b

$data modify storage datalib:engine _dispatch.func set value "$(func)"
function #datalib:internal/dispatch

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/once_per_player ","color":"aqua"},{"text":"$(player):$(key) ","color":"white"},{"text":"✔ ran for the first time","color":"green"}]
