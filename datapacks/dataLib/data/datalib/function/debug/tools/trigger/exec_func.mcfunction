# type:"func" → {ns:"namespace", path:"func/path"}
# NOTE: Two-part path construction — cannot route via #datalib:internal/dispatch
# without a pre-concat step. Intentional exception; this is admin-debug only.
$execute as @a[nbt=$(uuid)] at @s run function $(ns):$(path)
