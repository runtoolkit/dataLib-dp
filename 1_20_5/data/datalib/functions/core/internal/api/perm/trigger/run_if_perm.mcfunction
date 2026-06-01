execute if entity @s[tag=datalib.admin] run function datalib:core/internal/api/perm/trigger/exec with storage datalib:engine _ptd_current

$execute unless entity @s[tag=datalib.admin] if entity @s[tag=perm.$(perm)] run function datalib:core/internal/api/perm/trigger/exec with storage datalib:engine _ptd_current

$execute unless entity @s[tag=datalib.admin] unless entity @s[tag=perm.$(perm)] run tellraw @s {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" — you don't have this permission.","color":"red"}]}
