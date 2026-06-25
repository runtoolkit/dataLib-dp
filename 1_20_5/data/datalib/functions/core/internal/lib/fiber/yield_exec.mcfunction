# datalib:core/internal/lib/fiber/yield_exec [MACRO]
# INPUT: $(id), $(resume), $(delay)

# Do not continue if fiber is dead
$execute unless data storage datalib:engine fibers.$(id){alive:1b} run return 0

# Write resume point to fiber record (readable by is_alive/resume)
$data modify storage datalib:engine fibers.$(id).resume set value "$(resume)"

# Add this fiber's resume request to the _pending queue.
# resume_dispatch consumes _pending[0] each call → yield/dispatch match 1:1.
$data modify storage datalib:engine fibers._pending append value {id:"$(id)", func:"$(resume)"}

# Add dispatch entry to process_queue — runs after delay ticks
$data modify storage datalib:engine queue append value {func:"datalib:core/internal/lib/fiber/resume_dispatch", delay:$(delay)}

$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/yield ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(resume)","color":"aqua"},{"text":" in $(delay)t","color":"#555555"}]}
