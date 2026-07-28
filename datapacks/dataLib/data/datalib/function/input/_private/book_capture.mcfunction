# ======================================================================================
# datalib:input/_private/book_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a single player holding the marked written_book.
# Extracts SelectedItem.components."minecraft:writable_book_content".pages[0].raw
# into datalib:input storage. Read-only capture, no execution.
# ======================================================================================

data modify storage datalib:input book.player set from entity @s UUID
data modify storage datalib:input book.raw set from entity @s SelectedItem.components."minecraft:writable_book_content".pages[0].raw

# Same "raw, unvalidated, unexecuted" contract as command_block_minecart capture.
data modify storage datalib:input book.executed set value 0b
execute if data storage datalib:input book{executed:0b} run function #datalib:input/writable_book

# Clear the custom_data marker so the same book cannot be resubmitted every
# tick while the player keeps holding it — this is a one-shot capture.
data remove entity @s SelectedItem.components."minecraft:custom_data".dataLib.input
