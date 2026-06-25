# datalib:systems/dev_settings/display/close
# Removes the Dev Settings book from the player's inventory and resets cursor.

clear @s minecraft:written_book[custom_data={datalib_dev_settings:1b}]
scoreboard players reset @s dl.dev_pg2
playsound minecraft:entity.player.attack.nodamage player @s ~ ~ ~ 1 0.3
tellraw @s ["",{"text":"[Dev Settings] ","color":"gold"},{"text":"Book closed.","color":"gray"}]
