# dl_load:safe_load/yes
# Enhanced load confirmation gate with additional security precautions.
# Use INSTEAD OF dl_load:load/yes when operating in a security-critical context.
#
# PRECAUTIONS (over load/yes):
#   1. Gate must be open (#pending == 1)
#   2. Player caller: must have datalib.admin tag
#   3. Player caller: must have dl.perm_level >= 4 (super-admin)
#   4. Verifies engine is NOT already loaded
#   5. Logs all checks to server output via marker
#
# Non-player callers (server console / other datapacks) are trusted and bypass
# the player checks — they are already op-gated by the server.
#
# USAGE:
#   /function dl_load:safe_load/yes

# Guard: gate must be open
execute unless score #pending dl.load matches 1 run return 0

# Guard: already confirmed
execute if score #confirmed dl.load matches 1 run return 0

# Non-player callers: trusted — delegate directly
execute unless entity @s[type=minecraft:player] run summon minecraft:marker ~ ~ ~ {Tags:["datalib.safe_gate"],CustomName:{"text":"DL"}}
execute unless entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE] Confirmed by server/console — delegating to load/yes.
execute unless entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run kill @s
execute unless entity @s[type=minecraft:player] run function dl_load:load/yes
execute unless entity @s[type=minecraft:player] run return 0

# Player checks: datalib.admin tag required
execute unless entity @s[tag=datalib.admin] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — datalib.admin tag required.","color":"red"}]
execute unless entity @s[tag=datalib.admin] run return 0

# Player checks: perm_level >= 4 required
execute unless score @s dl.perm_level matches 4.. run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — dl.perm_level >= 4 required.","color":"red"}]
execute unless score @s dl.perm_level matches 4.. run return 0

# Guard: engine must NOT be already loaded
execute if data storage datalib:engine global{loaded:1b} run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — engine is already loaded.","color":"red"}]
execute if data storage datalib:engine global{loaded:1b} run return 0

# All checks passed — announce via marker
summon minecraft:marker ~ ~ ~ {Tags:["datalib.safe_gate"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE] ============================================
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE] safe_load/yes — all security checks PASSED.
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE]   datalib.admin tag: OK
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE]   perm_level >= 4: OK
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE]   engine not loaded: OK
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE]   Delegating to load/yes...
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run say [DL SAFE GATE] ============================================
execute as @e[type=minecraft:marker,tag=datalib.safe_gate,limit=1] run kill @s

# Delegate to regular load/yes
function dl_load:load/yes


# Enable sandbox mode
data modify storage datalib:engine sandbox set value 1b

# Leave players unsafe by default (v6.0.0 default is already 0b)
data modify storage datalib:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
