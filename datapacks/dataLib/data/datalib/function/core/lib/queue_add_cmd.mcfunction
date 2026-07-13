$data modify storage datalib:engine queue append value {cmd:"$(cmd)", delay:$(delay)}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/queue_add_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(cmd)","color":"aqua"}]
