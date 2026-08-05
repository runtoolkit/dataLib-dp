tellraw @a[tag=datalib.debug] {"text":"[DEBUG] Event system test starting...","color":"yellow"}

data modify storage datalib:input event set value "on_join"
data modify storage datalib:input func set value "datalib:debug/internal/on_join_handler"
function datalib:events/register with storage datalib:input {}

data modify storage datalib:input event set value "on_kill"
data modify storage datalib:input func set value "datalib:debug/internal/on_kill_handler"
function datalib:events/register with storage datalib:input {}

data remove storage datalib:engine event_context
data modify storage datalib:engine event_context.player set value "TestPlayer"
data modify storage datalib:engine event_context.reason set value "debug_test"

data modify storage datalib:input event set value "on_join"
function datalib:events/fire with storage datalib:input {}
data remove storage datalib:input event

tellraw @a[tag=datalib.debug] {"text":"[DEBUG] example_events completed.","color":"green"}