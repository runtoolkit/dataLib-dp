# datalib:systems/sound/stop
# Stops a specific sound (and category) on a target selector.
#
# Input  (datalib:input sound):
#   target   — selector string  e.g. "@a"  "@s"
#   category — source category  (use "*" to match all categories)
#   sound    — sound event ID   (use "*" to stop all sounds in category)
#
# Usage:
#   data modify storage datalib:input sound set value \
#     {target:"@a",category:"*",sound:"*"}
#   function datalib:systems/sound/stop with storage datalib:input sound

$stopsound $(target) $(category) $(sound)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"sound/stop ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(target)","color":"white"},{"text":" [","color":"#555555"},{"text":"$(category)","color":"green"},{"text":"] ","color":"#555555"},{"text":"$(sound)","color":"#AAAAAA"}]
