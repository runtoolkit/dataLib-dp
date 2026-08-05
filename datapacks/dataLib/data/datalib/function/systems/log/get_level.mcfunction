# datalib:systems/log/get_level
# Usage: /function datalib:systems/log/get_level
# Shows the current log level.
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"Log level: ","color":"gray"},{"score":{"name":"#dl.log_level","objective":"dl.log_level"},"color":"white","bold":true},{"text":"  (0=off 1=error 2=warn 3=info 4=debug)","color":"#555555"}]
