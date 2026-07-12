# ─────────────────────────────────────────────────────────────────
# datalib:api/wand/cooldown_check
# Checks whether the wand cooldown is active.
# NOTE: Wand cooldowns are stored under datalib:engine wand_cooldowns;
#      this avoids collision with datalib:cooldown module's "$(player).$(key)" path
# so there is zero risk of key collision.
#
# INPUT:
#   $(player) → player name
#   $(tag)    → wand tag
# OUTPUT:
# datalib:output result → 0b=ready (no cooldown), 1b=cooldown active
# ─────────────────────────────────────────────────────────────────

data modify storage datalib:output result set value 0b

$execute unless data storage datalib:engine wand_cooldowns.$(player).$(tag) run return 0

$execute store result score $wcc_exp dl.tmp run data get storage datalib:engine wand_cooldowns.$(player).$(tag)
execute store result score $wcc_now dl.tmp run scoreboard players get $epoch datalib.time

execute if score $wcc_now dl.tmp < $wcc_exp dl.tmp run data modify storage datalib:output result set value 1b
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"wand/cooldown_check ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" [$(tag)] → ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"}]
