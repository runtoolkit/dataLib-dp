# datalib:core/security/input_ns_violation
# Fired when func does not start with datalib:api/ (namespace violation).
#
# BUG FIX: Previously wrote log fields directly to datalib:input, then
# called the log system, then deleted them. This was a TOCTOU hazard:
# if another call arrived in the same tick after the write but before
# the delete, the caller's own datalib:input data would be corrupted.
#
# Fix: use datalib:debug as isolated scratch storage for log writes.
# datalib:input is never touched here.

# Write log fields to isolated debug scratch storage (not datalib:input) - SEV: WARN
data modify storage datalib:debug log.message set value "[Security] input_ns_violation — func outside datalib:api/* namespace"
data modify storage datalib:debug log.level set value "WARN"
data modify storage datalib:debug log.color set value "yellow"
execute if score #dl.log_level dl.log_level matches 1.. run function datalib:systems/log/add with storage datalib:debug log
data remove storage datalib:debug log

# Notify caller — only if @s is a player (non-player callers have no chat)
execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"#FFCC00"},{"text":"Security Warning: function call outside permitted namespace (datalib:api/*).","color":"#FFCC00"}]

# Notify debug admins (always — admin tag may be on non-player entities too)
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"NS WARNING ","color":"#FFCC00","bold":true},{"selector":"@s","color":"gold"},{"text":" — func not in datalib:api/*","color":"#FFCC00"}]