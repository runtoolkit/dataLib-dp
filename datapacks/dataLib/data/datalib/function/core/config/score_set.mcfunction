# datalib:core/config/score_set
# Sets an integer config value on the datalib.config scoreboard.
# Usage: $function datalib:core/config/score_set {key:"damage",value:5}
# Read back: scoreboard players get #damage datalib.config
$scoreboard players set #$(key) datalib.config $(value)
