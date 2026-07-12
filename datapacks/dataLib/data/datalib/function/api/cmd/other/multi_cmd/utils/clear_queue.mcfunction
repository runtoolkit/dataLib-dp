# ─────────────────────────────────────────────────────────────────
# datalib:api/cmd/other/multi_cmd/utils/clear_queue
# Clear the queue
# ─────────────────────────────────────────────────────────────────

data remove storage datalib:engine _mcmd_queue
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/utils/clear ","color":"aqua"},{"text":"✔ queue cleared","color":"yellow"}]
