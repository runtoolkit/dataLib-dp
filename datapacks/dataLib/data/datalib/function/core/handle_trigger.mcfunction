#> Handle datalib_settingsBook
execute if score @s datalib_settingsBook matches 1.. run function datalib:systems/dev_settings/display/open
scoreboard players set @s datalib_settingsBook 0
scoreboard players enable @s datalib_settingsBook