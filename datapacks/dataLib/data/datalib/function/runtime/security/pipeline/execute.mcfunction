# Run (Safely isolated)
$$(cmd)

tellraw @a[tag=datalib.debug] ["",{"text":"[DL-SEC] ","color":"green","bold":true},{"text":"Pipeline executed successfully.","color":"gray"}]

# Cleanup
data remove storage datalib:engine security.isolation_buffer
data remove storage datalib:engine security.canary
data remove storage datalib:input raw_command
