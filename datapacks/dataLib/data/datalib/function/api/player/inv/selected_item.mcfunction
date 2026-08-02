$execute as @a[name=$(player),limit=1] as @a at @s if items entity @s weapon.mainhand $(item)[minecraft:custom_data=$(customData)] run $(invoke)
