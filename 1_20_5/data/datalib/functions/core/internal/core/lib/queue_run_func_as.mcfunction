$data modify storage datalib:engine _dispatch.func set value "$(func)"
$execute as $(player) at @s run function #datalib:internal/dispatch
