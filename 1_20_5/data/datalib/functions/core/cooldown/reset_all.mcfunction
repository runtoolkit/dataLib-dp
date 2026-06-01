# ─────────────────────────────────────────────────────────────────
# datalib:core/cooldown/reset_all
# Clears all active cooldowns for a player.
#  Girdi : $(player) → player name
# Output: (side effect only)
#
# Example:
# data modify storage datalib:input player set value "Steve"
# function datalib:core/cooldown/reset_all with storage datalib:engine {}
# ─────────────────────────────────────────────────────────────────

$data remove storage datalib:engine cooldowns.$(player)
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"cooldown/reset_all ","color":"aqua"},{"text":"$(player) all cooldowns cleared","color":"yellow"}]}
