# datalib:systems/rate_limit/check — Sliding window check + consume [MACRO]
#
# The core API call. Checks whether the key is under its configured limit
# for the current sliding window, then records this hit.
#
# Output → datalib:output result
# 1b = ALLOWED (hit was recorded, call may proceed)
# 0b = DENIED (limit reached, hit NOT recorded)
#
# Usage:
# function datalib:systems/rate_limit/check {key:"global:my_event"}
# execute if data storage datalib:output {result:1b} run function my_ns:do_thing
#
# For per-player (build key in caller):
#   $function datalib:systems/rate_limit/check {key:"player:shop:$(player)"}
#
# Rule must be pre-registered via datalib:systems/rate_limit/config.
# If no rule exists for the key → ALLOWED (fail-open; log warning).

data modify storage datalib:output result set value 1b

# Guard: rule must exist — try auto-create from player template first
# Key format "player:<tpl>:<name>" → tpl is the second segment
# We attempt player_ensure unconditionally; it exits early if not a player key or no template
$data modify storage datalib:rl_work ensure_key set value "$(key)"
function datalib:core/internal/systems/rate_limit/player_check with storage datalib:rl_work

$execute unless data storage datalib:engine rate_limit.rules.$(key) run function datalib:core/internal/systems/rate_limit/no_rule
$execute unless data storage datalib:engine rate_limit.rules.$(key) run return 0

# Copy rule into work storage with key context
$data modify storage datalib:rl_work rule set from storage datalib:engine rate_limit.rules.$(key)
$data modify storage datalib:rl_work rule.key set value "$(key)"

# Run the sliding window evaluation
function datalib:core/internal/systems/rate_limit/evaluate with storage datalib:rl_work rule
