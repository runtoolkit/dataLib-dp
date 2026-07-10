# datalib:core/lib/batch/internal/flush_queue_cmd [MACRO]
# INPUT: $(cmd), $(delay) — from _bfl_cur; cmd field guaranteed.

$data modify storage datalib:engine queue append value {cmd:"$(cmd)", delay:$(delay)}
