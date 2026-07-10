# ─────────────────────────────────────────────────────────────────
# datalib:systems/geo/region_watch/list
# Shows all registered regions to debug players.
# ─────────────────────────────────────────────────────────────────

tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Region Watches ━━━━━━━━━━━━━━","color":"aqua"}]
execute if data storage datalib:engine region_watches run tellraw @a[tag=datalib.debug] ["",{"text":" ","color":"#555555"},{"storage":"datalib:engine","nbt":"region_watches","interpret":false,"color":"yellow"}]
execute unless data storage datalib:engine region_watches run tellraw @a[tag=datalib.debug] ["",{"text":" (no regions registered)","color":"gray","italic":true}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
