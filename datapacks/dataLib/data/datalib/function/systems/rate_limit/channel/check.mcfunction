# datalib:systems/rate_limit/channel/check — Per-channel rate guard [MACRO]
#
# Prevents a tick channel's function from running too frequently even if
# the channel itself fires every tick. Place at the TOP of the channel function.
#
# Usage (inside your channel function):
# function datalib:systems/rate_limit/channel/check {id:"my_channel"}
# execute if data storage datalib:output {result:0b} run return 0
# # ... rest of channel logic
#
# Rule must be registered via:
# function datalib:systems/rate_limit/channel/config {id:"my_channel",limit:5,window:20}
#
# Output → datalib:output result 1b=ALLOWED 0b=DENIED

$function datalib:systems/rate_limit/check {key:"channel:$(id)"}
