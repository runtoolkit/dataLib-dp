# ─────────────────────────────────────────────────────────────────
# datalib:systems/geo/region_watch/register
# Defines a persistent region. Player position is checked every tick;
# on_enter fires when a player enters, on_leave when they leave.
# Depends on the hook/internal/tick_scan loop.
#
# INPUT (storage datalib:input):
# id → region id (unique string)
# x1, y1, z1, x2, y2, z2 → corner coordinates (integer)
# on_enter → (optional) entry function — as the triggering player
# on_leave → (optional) leave function — as the triggering player
# on_enter_cmd → (optional) entry command
# on_leave_cmd → (optional) leave command
#
# EXAMPLE:
# data modify storage datalib:input id set value "spawn_safe"
# data modify storage datalib:input x1 set value 0
# data modify storage datalib:input y1 set value 60
# data modify storage datalib:input z1 set value 0
# data modify storage datalib:input x2 set value 100
# data modify storage datalib:input y2 set value 120
# data modify storage datalib:input z2 set value 100
# data modify storage datalib:input on_enter set value "mypack:zones/safe_enter"
# data modify storage datalib:input on_leave set value "mypack:zones/safe_leave"
# function datalib:systems/geo/region_watch/register
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/geo/region_watch/register_exec with storage datalib:engine {}
