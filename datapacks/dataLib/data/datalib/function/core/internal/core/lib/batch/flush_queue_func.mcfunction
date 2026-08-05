# datalib:core/lib/batch/internal/flush_queue_func [MACRO]
# INPUT: $(delay) — func is NBT-copied from _bfl_cur, not macro-spliced

$data modify storage datalib:engine queue append value {func:"", delay:$(delay)}
data modify storage datalib:engine queue[-1].func set from storage datalib:engine _bfl_cur.func
