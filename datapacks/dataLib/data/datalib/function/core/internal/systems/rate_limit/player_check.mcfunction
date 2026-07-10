# datalib:systems/rate_limit/internal/player_check — Auto-ensure player bucket if needed [MACRO]
# Input: $(ensure_key) — the full compound key from check
#
# Only acts when:
# 1. Key starts with "player:" (checked via NBT string prefix match workaround)
# 2. No rule exists yet for that key
# 3. A player_template exists for the base key portion
#
# Since we can't do string operations in mcfunction, we use a two-pass approach:
# player/check wrapper sets both $(key) and $(tpl) explicitly, so
# this file is only reached from the generic check path.
# In that case, just check if rule exists and exit if it does.

$execute if data storage datalib:engine rate_limit.rules.$(ensure_key) run return 0

# Rule absent. If this looks like a player key the wrapper already pre-seeded it.
# Nothing more to do here — no_rule path handles the rest.
