# datalib:core/security/type_violation/notify_admins [1_20_5 OVERLAY] [MACRO]
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"TYPE VIOLATION ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — blocked: ","color":"red"},{"text":"$(_violation_type)","color":"yellow"}]
