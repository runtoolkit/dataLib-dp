# dl_load:gate/timeout
# Fires 30 seconds after dl_load:gate/request if no admin response.
#
# Delegates to dl_load:gate/no which is idempotent — if the gate was
# already closed by an explicit /yes or /no, the #pending guard in
# gate/no returns 0 and nothing happens.

tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Dangerous command timeout (30s)","color":"red"},{"text":" — auto-cancelling.","color":"gray"}]

execute if score #pending dl.gate matches 1 run function dl_load:gate/no
