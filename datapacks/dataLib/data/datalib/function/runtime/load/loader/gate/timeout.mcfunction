# datalib:runtime/load/loader/gate/timeout
# Fires 30 seconds after datalib:runtime/load/loader/gate/request if no admin response.
#
# Delegates to datalib:runtime/load/loader/gate/no which is idempotent — if the gate was
# already closed by an explicit /yes or /no, the #pending guard in
# gate/no returns 0 and nothing happens.

tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Dangerous command timeout (30s)","color":"red"},{"text":" — auto-cancelling.","color":"gray"}]

execute if score #pending dl.gate matches 1 run function datalib:runtime/load/loader/gate/no
