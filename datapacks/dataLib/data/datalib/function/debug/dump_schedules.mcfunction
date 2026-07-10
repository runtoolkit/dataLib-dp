# ─────────────────────────────────────────────────────────────────
# datalib:debug/dump_schedules
# Shows active schedules and the queue.
# Usage: /function datalib:debug/dump_schedules
# ─────────────────────────────────────────────────────────────────

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Schedule / Queue Dump ","color":"aqua"},{"text":"━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"schedules","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:engine","nbt":"schedules","color":"gold","italic":false}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"queue ","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:engine","nbt":"queue","color":"gold","italic":false}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"throttle ","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:engine","nbt":"throttle","color":"gray","italic":false}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]