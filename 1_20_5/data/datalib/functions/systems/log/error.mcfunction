$data modify storage datalib:engine _log_add_tmp.message set value "$(message)"
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
function datalib:systems/log/add with storage datalib:engine {}
tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"log/error ","color":"aqua"}]}
