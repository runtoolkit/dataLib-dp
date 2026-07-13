# Add forceload
forceload add 0 0

# Execute command from storage using marker + command block
setblock 0 -64 0 minecraft:command_block{Command:"",auto:0b,TrackOutput:0b} replace
data modify block 0 -64 0 Command set from storage datalib:input cmd
data modify block 0 -64 0 auto set value 1b

schedule function datalib:api/cmd/run_cb_reset 2t replace