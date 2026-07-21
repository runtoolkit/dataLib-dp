# dl_load:loader/modules
# Extracted from loader/storages — module toggle init previously lived
# inline as a block of 'unless data' guards for modules.hook/interaction/
# perm/wand/geo/cb. This isolates that block so a new module's default
# toggle state has one place to register, instead of editing
# loader/storages directly.
#
# Called from loader/storages at the same point the old inline block sat.
# Preserved across reloads via 'unless data' guards — admin toggles survive /reload.
# Disable a module:  /function datalib:api/toggle/<name>/false
# Enable a module:   /function datalib:api/toggle/<name>/true
# List module states: /function datalib:api/toggle/list

execute unless data storage datalib:engine modules.hook run data modify storage datalib:engine modules.hook set value 1b
execute unless data storage datalib:engine modules.interaction run data modify storage datalib:engine modules.interaction set value 1b
execute unless data storage datalib:engine modules.perm run data modify storage datalib:engine modules.perm set value 1b
execute unless data storage datalib:engine modules.wand run data modify storage datalib:engine modules.wand set value 1b
execute unless data storage datalib:engine modules.geo run data modify storage datalib:engine modules.geo set value 1b
execute unless data storage datalib:engine modules.cb run data modify storage datalib:engine modules.cb set value 1b
