# datalib:systems/log/testblock/unpulse_at
# Scheduled 1 tick after pulse_at — resets powered to 0b so the block is
# ready to detect the next power transition. Message text is left as-is
# (harmless; it's overwritten on the next pulse anyway) and read from
# the persistent debug_log_pos rather than tick_work, since tick_work
# may have been overwritten by other tick-loop activity in that 1 tick.

function datalib:systems/log/testblock/unpulse_here with storage datalib:engine debug_log_pos
