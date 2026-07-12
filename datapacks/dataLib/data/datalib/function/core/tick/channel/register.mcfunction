# datalib:core/tick/channel/register — Register or replace a tick channel
# Usage:
# function datalib:core/tick/channel/register {id:"my_sys",rate:20,offset:0,fn:"my_ns:tick/my_system",enabled:1,condition:""}
#
# Fields:
# id (string) — unique channel identifier
# enabled (0|1) — 1 = active, 0 = paused; stored as byte internally
# rate (int) — fire every N ticks (1 = every tick, 20 = 1/s, 1200 = 1/min)
# offset (int) — phase shift 0..(rate-1); spread channels to avoid lag spikes
# fn (string) — function resource location to execute
# condition (string) — predicate path, or "" to always fire regardless of world state

# Remove any existing channel with same ID (idempotent)
$data remove storage datalib:engine tick.channels[{id:"$(id)"}]

# Append new channel definition
$data modify storage datalib:engine tick.channels append value {id:"$(id)",enabled:$(enabled)b,rate:$(rate),offset:$(offset),fn:"$(fn)",condition:"$(condition)"}