# datalib:disable — Dangerous command (confirmation gate required)
#
# Shuts down dataLib: removes all DL scoreboards, wipes datalib:engine
# and datalib:input storage, kills all DL marker entities.
#
# CHANGE FROM PREVIOUS BEHAVIOUR
# --------------------------------
# This function NO LONGER runs cleanup immediately.
# It stores the disable intent in datalib:engine pending_gate and opens the
# dangerous-command gate. Cleanup runs only after admin confirms:
#   /function dl_load:gate/yes
#
# To cancel:
#   /function dl_load:gate/no
#
# Auto-cancel fires after 30 seconds if no response.
#
# REQUIRES: datalib.admin tag on calling entity
# (check_all → perm_check verifies this before any caller reaches here)

data modify storage datalib:engine pending_gate set value {type:"disable"}
function dl_load:gate/request
