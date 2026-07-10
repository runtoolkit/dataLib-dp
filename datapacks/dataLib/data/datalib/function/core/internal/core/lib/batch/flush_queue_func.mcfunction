# datalib:core/lib/batch/internal/flush_queue_func [MACRO]
# INPUT: $(func), $(delay) — _bfl_cur'dan; func field guaranteed.

$data modify storage datalib:engine queue append value {func:"$(func)", delay:$(delay)}
