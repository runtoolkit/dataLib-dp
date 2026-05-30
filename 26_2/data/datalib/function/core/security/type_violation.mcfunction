# datalib:core/security/type_violation
# Fired when a sandbox-blocked command type is called.
# Logs ERROR, notifies caller, notifies debug admins, kicks player.
# Context: @s = offending player. datalib:input._violation_type = command name.

# Log entry
data modify storage datalib:input message set value "[Security] type_violation — sandbox command not in allowlist"
data modify storage datalib:input level set value "ERROR"
data modify storage datalib:input color set value "red"
execute if score #dl.log_level dl.log_level matches 2.. run function datalib:systems/log/add with storage datalib:input {}
data remove storage datalib:input message
data remove storage datalib:input level
data remove storage datalib:input color

# Notify player
tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security violation: command not permitted in sandbox mode.","color":"red"}]

# Notify debug admins with command name context
function datalib:core/security/type_violation/notify_admins with storage datalib:input {}

# Kick offending player (26.2+: kick cannot be used inside execute...run)
kick @s [DL] Security violation - sandbox command blocked
