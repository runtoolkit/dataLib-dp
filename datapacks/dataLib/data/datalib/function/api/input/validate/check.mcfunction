# ======================================================================================
# datalib:api/input/validate/check
# ======================================================================================
#
# TYPE-SAFETY GUARD FOR CAPTURED PLAYER INPUT.
#
# Every input capture point (book_capture, dialog_capture, cbm_capture) only
# ever stores the RAW string a player submitted — it does not know or care
# whether that string is the shape the caller actually needs. This function
# is the missing check: run it AFTER a capture, BEFORE you use the value as
# a number, bool, or safe scoreboard/tag literal.
#
# THIS DOES NOT EXECUTE THE INPUT. It only reads it and reports pass/fail.
#
# CALL WITH:
#   function datalib:api/input/validate/check with storage <yourpath> {source: "<path.to.field>", type: "int"|"float"|"bool"|"tag_safe"}
#
#   $(source) — a dot-path INTO datalib:input, e.g. "book.raw", "dialog.raw",
#               "cbm.command". Read via macro from datalib:input directly.
#   $(type)   — one of:
#       "int"      — string must parse as a whole number (optional leading -)
#       "float"    — string must parse as int or decimal (optional leading -)
#       "bool"     — string must be exactly "true" or "false"
#       "tag_safe" — string must contain none of: space, ", ', {, }, [, ], :,
#                    the literal backslash character, or be empty. Safe to use
#                    as a scoreboard objective/player name fragment or a
#                    single unquoted NBT string component.
#
# OUTPUT (written to storage datalib:input_validate result):
#   result.valid    — 1b if input matches the requested type, else 0b
#   result.error    — human-readable reason when invalid (unset when valid)
#   result.value    — for "int"/"float": the raw string, unchanged (caller
#                     still owns turning it into a real number via
#                     datalib:modules/string/api/legacy/to_number AFTER checking result.valid —
#                     this function never calls to_number itself, since
#                     to_number has no failure mode of its own: feeding it
#                     a non-numeric string produces a raw SNBT parse error
#                     instead of a clean invalid result, which is exactly
#                     the gap this function exists to close upstream of it)
#
# THIS FUNCTION NEVER $$(...) MACRO-EXECUTES THE INPUT STRING. It only
# calls datalib:modules/string/api/legacy/find (read-only string search) against it.
# ======================================================================================

data remove storage datalib:input_validate result
data modify storage datalib:input_validate result.valid set value 0b

$data modify storage datalib:input_validate scratch.value set from storage datalib:input $(source)
$data modify storage datalib:input_validate scratch.type set value "$(type)"

execute if data storage datalib:input_validate {scratch:{type:"int"}} run function datalib:api/input/validate/_private/check_int
execute if data storage datalib:input_validate {scratch:{type:"float"}} run function datalib:api/input/validate/_private/check_float
execute if data storage datalib:input_validate {scratch:{type:"bool"}} run function datalib:api/input/validate/_private/check_bool
execute if data storage datalib:input_validate {scratch:{type:"tag_safe"}} run function datalib:api/input/validate/_private/check_tag_safe

data remove storage datalib:input_validate scratch
