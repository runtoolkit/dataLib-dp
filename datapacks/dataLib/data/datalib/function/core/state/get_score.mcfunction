# datalib:core/state/get_score
# Prints the calling player's current state score.
# Usage: /function datalib:core/state/get_score
tellraw @s ["",{"text":"[State] ","color":"aqua"},{"text":"current: ","color":"gray"},{"score":{"name":"@s","objective":"datalib.state"},"color":"white","bold":true}]
