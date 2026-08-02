# datalib:internal/rate_limit/api/global/config — Register a global (server-wide) rate limit [MACRO]
#
# Usage:
# function datalib:internal/rate_limit/api/global/config {key:"boss_spawn",limit:1,window:24000}
#
# Equivalent to:
# function datalib:internal/rate_limit/api/config {key:"global:boss_spawn",limit:1,window:24000}

$function datalib:internal/rate_limit/api/config {key:"global:$(key)",limit:$(limit),window:$(window)}
