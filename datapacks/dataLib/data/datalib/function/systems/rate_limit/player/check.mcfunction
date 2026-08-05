# datalib:systems/rate_limit/player/check — Per-player sliding window check [MACRO]
#
# Builds the compound key "player:<key>:<player>" and ensures the bucket exists.
# If no bucket exists yet for this player, auto-creates from the player_template.
#
# Usage:
#   $function datalib:systems/rate_limit/player/check {key:"shop",player:"$(player)"}
#
# Rule template must be registered via:
# function datalib:systems/rate_limit/player/config {key:"shop",limit:3,window:600}
#
# Output → datalib:output result 1b=ALLOWED 0b=DENIED

# Auto-seed: if bucket for this player+key doesn't exist, create from template
$execute unless data storage datalib:engine "rate_limit.rules.player:$(key):$(player)" run function datalib:core/internal/systems/rate_limit/player/ensure {tpl:"$(key)",full:"player:$(key):$(player)"}

# Delegate to generic check with full compound key
$function datalib:systems/rate_limit/check {key:"player:$(key):$(player)"}
