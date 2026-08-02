# datalib:internal/rate_limit/api/player/check — Per-player sliding window check [MACRO]
#
# Builds the compound key "player:<key>:<player>" and ensures the bucket exists.
# If no bucket exists yet for this player, auto-creates from the player_template.
#
# Usage:
#   $function datalib:internal/rate_limit/api/player/check {key:"shop",player:"$(player)"}
#
# Rule template must be registered via:
# function datalib:internal/rate_limit/api/player/config {key:"shop",limit:3,window:600}
#
# Output → datalib:output result 1b=ALLOWED 0b=DENIED

# Auto-seed: if bucket for this player+key doesn't exist, create from template
$execute unless data storage datalib:engine "rate_limit.rules.player:$(key):$(player)" run function datalib:internal/rate_limit/player/ensure {tpl:"$(key)",full:"player:$(key):$(player)"}

# Delegate to generic check with full compound key
$function datalib:internal/rate_limit/api/check {key:"player:$(key):$(player)"}
