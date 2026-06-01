# datalib:core/internal/systems/hook/on_advancement_fire [MACRO]
# INPUT: $(advancement)
# @s = player who earned the advancement

$data modify storage datalib:engine _hook_fire_tmp set value {event:"advancement:$(advancement)"}
function datalib:core/internal/systems/hook/fire with storage datalib:engine _hook_fire_tmp
data remove storage datalib:engine _hook_fire_tmp

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"hook/on_advancement_fire ","color":"aqua"},{"text":"advancement:$(advancement)","color":"yellow"}]
