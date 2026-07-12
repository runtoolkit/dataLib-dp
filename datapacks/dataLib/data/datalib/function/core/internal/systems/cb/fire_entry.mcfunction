# datalib:systems/cb/internal/fire_entry
# Fires the command in _cb_entry via command block.
# Reuses api/cb/internal machinery.

# Copy to input storage, reuse exec path
data modify storage datalib:input cb set from storage datalib:engine _cb_entry
function datalib:core/internal/api/cb/exec with storage datalib:input cb
data remove storage datalib:input cb
