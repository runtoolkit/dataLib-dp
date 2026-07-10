# ─────────────────────────────────────────────────────────────────
# datalib:debug/dump_events
# Lists all registered event handlers.
# Usage: /function datalib:debug/dump_events
# ─────────────────────────────────────────────────────────────────

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Event Registry ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"engine.events","color":"white"},{"text":" → ","color":"#555555"},{"storage":"datalib:engine","nbt":"events","color":"light_purple","italic":false}]
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]