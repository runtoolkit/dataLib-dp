# Module toggle guard — skips this module when disabled via datalib:api/toggle/interaction/false
execute unless data storage datalib:engine {modules:{interaction:1b}} run return 0

execute unless entity @e[type=minecraft:interaction,tag=datalib.interaction,limit=1] run return 0

execute if data storage datalib:engine interaction_binds.attack[0] run execute as @e[type=minecraft:interaction,tag=datalib.interaction] if data entity @s attack run function datalib:core/internal/api/interaction/on_attack

execute if data storage datalib:engine interaction_binds.use[0] run execute as @e[type=minecraft:interaction,tag=datalib.interaction] if data entity @s interaction run function datalib:core/internal/api/interaction/on_use
