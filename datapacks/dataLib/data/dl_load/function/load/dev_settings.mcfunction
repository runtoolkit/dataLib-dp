# dl_load:load/dev_settings
# Initializes datalib:engine dev_settings storage fields on first load.
# All writes are guarded with 'execute unless data' — existing values are preserved.
#
# Fields:
#   dev_settings.devMode    0b = dev mode disabled (default)
#   dev_settings.version    version target: 116 | 117 | 118 | 119 | 120 (default: 120)

execute unless data storage datalib:engine dev_settings run data modify storage datalib:engine dev_settings set value {devMode:0b,version:120}
execute unless data storage datalib:engine dev_settings.devMode run data modify storage datalib:engine dev_settings.devMode set value 0b
execute unless data storage datalib:engine dev_settings.version run data modify storage datalib:engine dev_settings.version set value 120
