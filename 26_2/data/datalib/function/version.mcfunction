# ─────────────────────────────────────────────
# datalib:version
# Shows dataLib version info to the calling player.
# Usage: /function datalib:version
# ─────────────────────────────────────────────

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Version Info ","color":"aqua"},{"text":"━━━━━━━━━━━━━━","color":"#555555"}]

tellraw @s ["",{"text":" ◈ ","color":"#00AAAA"},{"text":"dataLib","color":"white","bold":true}]

execute if score #dl.pre dl.pre_version matches 1.. run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Version ","color":"gray"},{"text":"v","color":"#ffaa00"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"#ffaa00","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#dl.pre","objective":"dl.pre_version"},"color":"#ff8800","bold":true}]
execute if score #dl.pre dl.pre_version matches ..0 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Version ","color":"gray"},{"text":"v","color":"#ffaa00"},{"score":{"name":"#dl.major","objective":"dl.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#dl.minor","objective":"dl.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#dl.patch","objective":"dl.pre_version"},"color":"#ffaa00","bold":true}]

tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"MC ","color":"gray"},{"text":"1.20.3–26.1+","color":"#e3ff57"},{"text":" (pack_format 26–101.1)","color":"#555555"}]
tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Author ","color":"gray"},{"text":"Legends11","color":"#00ff33"},{"text":" / ","color":"#555555"},{"text":"runtoolkit","color":"aqua","underlined":true}]

tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Source ","color":"gray"},{"text":"github.com/runtoolkit/DataLib","color":"#5555ff","underlined":true}]
# Check if loaded
execute if score #dl.ver_set dl.pre_version matches 1 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Status ","color":"gray"},{"text":"● loaded","color":"green"}]
execute unless score #dl.ver_set dl.pre_version matches 1 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Status ","color":"gray"},{"text":"✖ not initialized","color":"red"}]

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]