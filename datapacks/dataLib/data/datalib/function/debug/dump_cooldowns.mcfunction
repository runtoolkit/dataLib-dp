# ─────────────────────────────────────────────────────────────────
# datalib:debug/dump_cooldowns
# Dumps all active cooldown records to screen.
# Usage: /function datalib:debug/dump_cooldowns
# ─────────────────────────────────────────────────────────────────

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Cooldown Dump ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"engine.cooldowns","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:engine","nbt":"cooldowns","color":"yellow","italic":false}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"epoch now: ","color":"gray"},{"score":{"name":"$epoch","objective":"datalib.time"},"color":"aqua"}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]