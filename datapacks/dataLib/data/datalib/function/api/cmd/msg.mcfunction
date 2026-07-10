execute unless function datalib:debug/tools/utils/check_all run return 0

$tellraw @a[name=$(player),limit=1] {"text":"$(message)","color":"gray","italic":true}
