# dl_load:gate/exec/kick
# Executor for confirmed player kick.
# Called by dl_load:gate/yes when pending_gate{type:"kick"}.
# Expects: {type:"kick", player:"<name>", reason:"<text>"}

$kick $(player) $(reason)

tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Kicked ","color":"yellow"},{"text":"$(player)","color":"aqua","bold":true},{"text":" — $(reason)","color":"gray"}]
