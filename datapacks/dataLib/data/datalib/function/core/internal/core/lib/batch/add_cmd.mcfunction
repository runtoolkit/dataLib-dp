# datalib:core/lib/batch/internal/add_cmd [MACRO]
# INPUT: $(id) — cmd is NBT-copied from datalib:input, not macro-spliced
# Called with cmd field guaranteed.

$data modify storage datalib:engine batches.$(id).items append value {cmd:""}
$data modify storage datalib:engine batches.$(id).items[-1].cmd set from storage datalib:input cmd
