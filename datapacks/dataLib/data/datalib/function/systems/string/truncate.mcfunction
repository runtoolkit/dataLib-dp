# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/truncate
# Displays text in the named player's actionbar, optionally with a
# suffix to indicate truncation. The caller decides whether the text
# needs truncating and passes truncated:1b or truncated:0b.
# Because mcfunction cannot measure string byte-length at runtime,
# length-checking must be done externally.
#
# INPUT : $(player)    → player name
#         $(text)      → string to display
#         $(suffix)    → suffix shown when truncated (e.g. "...")
#         $(truncated) → 1b = append suffix, 0b = show as-is
# OUTPUT: datalib:output text → stored original text
#
# EXAMPLE:
# function datalib:systems/string/truncate {player:"Steve",text:"Hello Wor",suffix:"...",truncated:1b}
# → actionbar: "Hello Wor..."
# ─────────────────────────────────────────────────────────────────

$data modify storage datalib:output text set value $(text)
$data modify storage datalib:engine _trunc_t set value $(truncated)

scoreboard players set #trunc_flag dl.tmp 0
execute store result score #trunc_flag dl.tmp run data get storage datalib:engine _trunc_t

$execute if score #trunc_flag dl.tmp matches 0 run title @a[name=$(player),limit=1] actionbar {"storage":"datalib:output","nbt":"text"}
$execute if score #trunc_flag dl.tmp matches 1.. run title @a[name=$(player),limit=1] actionbar ["",{"storage":"datalib:output","nbt":"text"},{"text":"$(suffix)","color":"gray"}]

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"string/truncate ","color":"aqua"},{"text":"$(player) truncated=$(truncated)","color":"gray"}]
