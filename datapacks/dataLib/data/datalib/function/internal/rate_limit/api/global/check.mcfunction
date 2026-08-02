# datalib:internal/rate_limit/api/global/check — Global sliding window check [MACRO]
#
# Convenience wrapper for global (server-wide) rate limits.
# All players share the same bucket under this key.
#
# Usage:
# function datalib:internal/rate_limit/api/global/check {key:"boss_spawn"}
#
# Rule must be registered via:
# function datalib:internal/rate_limit/api/global/config {key:"boss_spawn",limit:1,window:24000}
#
# Output → datalib:output result 1b=ALLOWED 0b=DENIED

$function datalib:internal/rate_limit/api/check {key:"global:$(key)"}
