# dl_load:timeout
# Fires 5 minutes after dl_load:load/confirm if no admin response.
#
# Uses tellraw @a — no marker entity needed, unlike the old 'say'
# pattern (say has no @a[tag=...] filter, which was the original
# reason for the marker-entity workaround).
#
# Delegates to dl_load:load/no which is idempotent — if the admin
# already ran /yes or /no, the #pending guard in load/no returns 0
# and nothing happens.

tellraw @a ["",{"text":"[DL GATE] ","color":"#555555"},{"text":"Timeout","color":"red","bold":true},{"text":" — no admin response in 5 minutes. Auto-cancelling.","color":"gray"}]

# Delegate to load/no (idempotent — no-op if gate already closed)
execute if score #pending dl.load matches 1 run function dl_load:load/no
