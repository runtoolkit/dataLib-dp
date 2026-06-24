execute unless entity @a run return 0
execute unless data storage datalib:engine global{loaded:1b} run return 0

execute if score #m_time datalib.Flags matches 1 run function datalib:core/tick/time_systems
execute if score #m_time datalib.Flags matches 0 run function datalib:core/tick/disabled

execute if score #m_queue datalib.Flags matches 1 run function datalib:core/tick/queue_systems
execute if score #m_queue datalib.Flags matches 0 run function datalib:core/tick/disabled

execute if score #m_player datalib.Flags matches 1 run function datalib:core/tick/player_systems
execute if score #m_player datalib.Flags matches 0 run function datalib:core/tick/disabled

execute if score #m_hud datalib.Flags matches 1 run function datalib:core/tick/hud_systems
execute if score #m_hud datalib.Flags matches 0 run function datalib:core/tick/disabled

execute if score #m_admin datalib.Flags matches 1 run function datalib:core/tick/admin_systems
execute if score #m_admin datalib.Flags matches 0 run function datalib:core/tick/disabled