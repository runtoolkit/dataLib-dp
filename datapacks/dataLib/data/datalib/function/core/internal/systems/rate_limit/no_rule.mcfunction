# datalib:systems/rate_limit/internal/no_rule — Warn when check called on unregistered key [MACRO]
# Input: $(key)
# Fail-open: result stays 1b (ALLOWED) so callers aren't broken by missing config.

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"rate_limit/check ","color":"aqua"},{"text":"WARN ","color":"#FFAA00"},{"text":"no rule for key: ","color":"#555555"},{"text":"$(key)","color":"#FF5555"},{"text":" — fail-open","color":"#555555"}]
