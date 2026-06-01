$data modify storage datalib:engine _log_add_tmp.message set value "$(message)"
data modify storage datalib:engine _log_add_tmp.level set value "DEBUG"
data modify storage datalib:engine _log_add_tmp.color set value "gray"
function datalib:systems/log/add with storage datalib:engine {}
tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"log/debug ","color":"aqua"}]}
