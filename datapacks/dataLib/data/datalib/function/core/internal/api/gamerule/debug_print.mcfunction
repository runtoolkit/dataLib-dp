# datalib:core/internal/api/gamerule/debug_print [MACRO]
# Internal — do not call directly.
#
# Emits the gamerule/get debug line. Split out from api/gamerule/get so the
# $(_gamerule_norm) macro arg is bound fresh from storage AFTER the normalize
# step writes it, instead of at get.mcfunction's own entry (before the value
# existed).
#
# Expects: {_gamerule_norm:"..."}

$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/get ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"plain":true ,"storage":"datalib:output","nbt":"gamerule","color":"green"}]
