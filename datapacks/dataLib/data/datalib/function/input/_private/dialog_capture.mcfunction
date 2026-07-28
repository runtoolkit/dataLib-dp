# ======================================================================================
# datalib:input/_private/dialog_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Called by the dialog system itself via its "run_command" action template
# (dialog-native substitution, NOT a datapack $$(cmd) macro chain). Receives
# the submitted text as $(value) and stores it — read-only capture, no
# execution of the submitted text as a command.
#
# NOTE: this file uses '$' line-macro syntax because it is invoked as a
# macro function (the dialog template calls it with a {value:...} NBT
# compound). This is NOT the $$(cmd) EXECUTION macro pattern Legends11
# asked to avoid — no field here is ever run as a command, only stored.
# ======================================================================================

data modify storage datalib:input dialog.raw set value "$(value)"
data modify storage datalib:input dialog.executed set value 0b
execute if data storage datalib:input dialog{executed:0b} run function #datalib:input/dialog