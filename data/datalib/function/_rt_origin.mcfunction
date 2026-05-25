scoreboard players set #runtoolkit.watermark datalib.meta 1
data modify storage datalib:engine global.rt_origin_verified set value 1b
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"dataLib","color":"aqua"},{"text":" © Legends11 / runtoolkit — ","color":"#555555"},{"text":"CC BY-NC-SA 4.0","color":"#888888"},{"text":" — ","color":"#555555"},{"text":"github.com/runtoolkit","color":"#888888","click_event":{"action":"open_url","url":"https://github.com/runtoolkit/dataLib"}}]
