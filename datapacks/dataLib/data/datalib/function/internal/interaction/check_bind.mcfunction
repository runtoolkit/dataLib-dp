$data modify storage datalib:engine _dispatch.func set value "$(func)"
$execute if entity @e[type=minecraft:interaction,tag=datalib.ia_active,tag=$(tag),limit=1] run function #datalib:internal/dispatch
