# datalib:systems/rate_limit/config — Register or update a rate limit rule [MACRO]
#
# Creates or replaces a sliding window rule for any key.
# Rules survive reloads because they live in datalib:engine storage.
#
# Usage:
# function datalib:systems/rate_limit/config {key:"global:my_event",limit:5,window:100}
# function datalib:systems/rate_limit/config {key:"player:Steve:shop",limit:3,window:600}
# function datalib:systems/rate_limit/config {key:"channel:admin_systems",limit:10,window:20}
#
# Fields:
# key (string) — unique rule identifier; convention:
# "global:<name>" → server-wide shared bucket
#                     "player:<name>:<player>" → per-player bucket (use $(player))
# "channel:<id>" → tick-channel guard
# limit (int) — max number of hits allowed inside the window
# window (int) — sliding window width in ticks (20 = 1 second)
#
# Removing a rule: function datalib:systems/rate_limit/delete {key:"..."}
# Listing rules: function datalib:systems/rate_limit/list

$data modify storage datalib:engine rate_limit.rules.$(key) set value {limit:$(limit),window:$(window),hits:[]}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"rate_limit/config ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(key)","color":"white"},{"text":" limit=","color":"#555555"},{"text":"$(limit)","color":"green"},{"text":" window=","color":"#555555"},{"text":"$(window)","color":"green"},{"text":"t","color":"#555555"}]
