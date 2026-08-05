# datalib:core/lib/batch/internal/flush_queue_cmd [MACRO]
# INPUT: $(delay) — cmd is NBT-copied from _bfl_cur, not macro-spliced

$data modify storage datalib:engine queue append value {cmd:"", delay:$(delay)}
data modify storage datalib:engine queue[-1].cmd set from storage datalib:engine _bfl_cur.cmd
