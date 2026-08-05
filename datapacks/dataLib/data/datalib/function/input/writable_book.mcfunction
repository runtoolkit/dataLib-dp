# ======================================================================================
# datalib:input/writable_book
# ======================================================================================
#
# TRIGGERED BY: #datalib:input/writable_book function tag
#
# PURPOSE:
#   Detect a player holding a written_book marked with
#   custom_data={dataLib:{input:1b}} (given via
#   'give @s minecraft:written_book[minecraft:custom_data={dataLib:{input:1b}}]'),
#   and extract the raw text of page[0] from
#   SelectedItem.components."minecraft:writable_book_content".pages[0].raw
#   into datalib:input storage. Input capture ONLY — no execution here.
#
# WHY THIS ONLY CHECKS THE MAINHAND SELECTED ITEM:
#   'SelectedItem' reflects the player's currently held mainhand item at
#   entity-data-read time. If the marked book is not currently selected,
#   this tick simply finds nothing — this is intentional, not a bug: we
#   don't want to scan a player's whole inventory every tick for cost
#   reasons, and forcing "hold it to submit" is a reasonable UX contract.
#
# NO MACRO, NO EXECUTION:
#   This function contains no $$(...) macro syntax. It only reads and
#   stores text. Whether the captured text is ever treated as a command
#   is entirely up to a separate, opt-in execution pack — never mandatory.
# ======================================================================================

# Fast exit — skip entirely if no player is holding the marked book
execute unless entity @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{dataLib:{input:1b}}}}}] run return 0

execute as @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{dataLib:{input:1b}}}}}] run function datalib:input/private/book_capture
