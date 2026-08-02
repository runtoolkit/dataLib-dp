$data modify storage datalib:engine queue append value {func:"$(func)", delay:$(delay), player:"$(player)"}
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/wait_as ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"},{"text":" ($(delay)t) as $(player)","color":"#555555"}]
