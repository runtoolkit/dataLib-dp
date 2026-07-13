# ─────────────────────────────────────────────
# datalib:core/lib/schedule_cmd
# Repeating command scheduler at a fixed interval.
#
# Girdi (datalib:input):
# key — scheduler name (unique identifier)
# cmd — raw command to run on each trigger
# interval — repeat interval in ticks
# ─────────────────────────────────────────────

$execute if data storage datalib:engine schedules.$(key) run data remove storage datalib:engine schedules.$(key)

$data modify storage datalib:engine schedules.$(key).cmd set value "$(cmd)"
$data modify storage datalib:engine schedules.$(key).interval set value $(interval)
$data modify storage datalib:engine queue append value {cmd:"$(cmd)", delay:$(interval)}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" ($(interval)t)","color":"#555555"}]
