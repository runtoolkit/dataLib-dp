$scoreboard players set $if_a dl.tmp $(a)
$scoreboard players set $if_b dl.tmp $(b)
$data modify storage datalib:engine _dispatch.func set value "$(func)"
execute if score $if_a dl.tmp = $if_b dl.tmp run function #datalib:internal/dispatch
