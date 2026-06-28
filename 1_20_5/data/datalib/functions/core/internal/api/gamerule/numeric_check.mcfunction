# datalib:core/internal/api/gamerule/numeric_check [MACRO]
$scoreboard players set #dl_gamerule_scratch dl.gamerule $(value)
$execute if score #dl_gamerule_scratch dl.gamerule matches $(gr_matches) run function $(gr_on_value)
