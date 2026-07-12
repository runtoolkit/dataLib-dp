# datalib:core/state/set_score
# Sets a player's integer state on the datalib.state scoreboard.
# Usage: $function datalib:core/state/set_score {value:1}
# States: 0=idle 1=combat 2=menu (define your own)
$scoreboard players set @s datalib.state $(value)
