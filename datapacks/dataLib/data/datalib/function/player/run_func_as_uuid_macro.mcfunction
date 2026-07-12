$data modify storage datalib:engine _dispatch.func set value "$(func)"
$execute as @a[nbt={UUID:$(uuid)}] run function #datalib:internal/dispatch