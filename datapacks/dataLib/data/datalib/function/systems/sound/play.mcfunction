# datalib:systems/sound/play
# Entity-targeted playsound wrapper.
# Runs at the executor's position — call inside  execute as <target> at @s  if
# positional accuracy matters (e.g. per-player distance checks).
#
# Input  (datalib:input sound):
#   sound    — sound event ID   e.g. "minecraft:entity.player.levelup"
#   category — source category  master|music|record|weather|block|
#                               hostile|neutral|player|ambient|voice
#   target   — selector string  e.g. "@a"  "@s"  "@p"
#   volume   — float ≥ 0        1.0 = full volume, >1 increases range
#   pitch    — float 0.0–2.0    1.0 = normal pitch
#
# Usage:
#   data modify storage datalib:input sound set value \
#     {sound:"minecraft:entity.player.levelup",category:"player",\
#      target:"@a",volume:1.0f,pitch:1.0f}
#   function datalib:systems/sound/play with storage datalib:input sound

$playsound $(sound) $(category) $(target) ~ ~ ~ $(volume) $(pitch)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"sound/play ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(sound)","color":"white"},{"text":" [","color":"#555555"},{"text":"$(category)","color":"green"},{"text":"]","color":"#555555"},{"text":" vol:","color":"#555555"},{"text":"$(volume)","color":"yellow"},{"text":" pitch:","color":"#555555"},{"text":"$(pitch)","color":"yellow"}]
