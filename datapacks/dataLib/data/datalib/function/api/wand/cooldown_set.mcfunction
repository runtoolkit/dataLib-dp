# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/cooldown_set
# Applies a cooldown to wand usage.
# NOTE: Wand cooldowns are stored under datalib:engine wand_cooldowns;
#      this avoids collision with datalib:cooldown module's "$(player).$(key)" path
# so there is zero risk of key collision.
#
# INPUT:
#   $(player)   → player name
#   $(tag)      → wand tag
#   $(duration) → cooldown duration (in ticks)
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $wcd_dur dl.tmp $(duration)
execute store result score $wcd_now dl.tmp run scoreboard players get $epoch datalib.time
scoreboard players operation $wcd_now dl.tmp += $wcd_dur dl.tmp
$execute store result storage datalib:engine wand_cooldowns.$(player).$(tag) int 1 run scoreboard players get $wcd_now dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/cooldown_set ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" [$(tag)] ","color":"#555555"},{"text":"$(duration)t","color":"green"}]
