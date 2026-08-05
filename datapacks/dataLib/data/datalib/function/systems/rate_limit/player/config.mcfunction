# datalib:systems/rate_limit/player/config — Register per-player rate limit rule [MACRO]
#
# Creates one template rule. The player bucket key is "player:<key>:<player>".
# This function registers the TEMPLATE rule used for ALL players under this key.
# Individual player buckets are auto-created on first check.
#
# Usage:
# function datalib:systems/rate_limit/player/config {key:"shop",limit:3,window:600}
#
# This allows: $function datalib:systems/rate_limit/player/check {key:"shop",player:"$(player)"}
#
# Note: each player gets their own independent sliding window bucket.
# To register a SHARED (global) rule use datalib:systems/rate_limit/config directly.

# Store template rule — concrete player buckets inherit limit+window on first hit
$data modify storage datalib:engine rate_limit.player_templates.$(key) set value {limit:$(limit),window:$(window)}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"rate_limit/player/config ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"player:$(key):<player>","color":"white"},{"text":" limit=","color":"#555555"},{"text":"$(limit)","color":"green"},{"text":" window=","color":"#555555"},{"text":"$(window)","color":"green"},{"text":"t","color":"#555555"}]
