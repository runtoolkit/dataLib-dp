# ======================================================================================
# datalib:api/input/validate/_private/check_tag_safe  [INTERNAL]
# ======================================================================================
# Rejects empty strings and any string containing one of: space " ' { } [ ] :
# or a literal backslash. Safe result can be used as a scoreboard
# objective/player-name fragment or dropped unquoted into a single NBT
# string field without needing escaping.
#
# One datalib:modules/string/api/legacy/find per forbidden character — fixed cost (9 calls),
# not per-character-of-input.
# ======================================================================================

execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.value
execute if score #DL.Len dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "empty input"
execute if score #DL.Len dl.tmp matches 0 run return 0

data modify storage datalib:stringlib_data.input find.String set from storage datalib:input_validate scratch.value
data modify storage datalib:stringlib_data.input find.n set value 1

data modify storage datalib:input_validate scratch.bad set value 0b

function datalib:api/input/validate/_private/reject_if_present {char:" "}
function datalib:api/input/validate/_private/reject_if_present {char:"\""}
function datalib:api/input/validate/_private/reject_if_present {char:"'"}
function datalib:api/input/validate/_private/reject_if_present {char:"{"}
function datalib:api/input/validate/_private/reject_if_present {char:"}"}
function datalib:api/input/validate/_private/reject_if_present {char:"["}
function datalib:api/input/validate/_private/reject_if_present {char:"]"}
function datalib:api/input/validate/_private/reject_if_present {char:":"}
function datalib:api/input/validate/_private/reject_if_present {char:"\\"}
function datalib:api/input/validate/_private/reject_if_present {char:"§"}
function datalib:api/input/validate/_private/reject_if_present {char:"|"}
function datalib:api/input/validate/_private/reject_if_present {char:"^"}
function datalib:api/input/validate/_private/reject_if_present {char:"<"}
function datalib:api/input/validate/_private/reject_if_present {char:">"}

execute unless data storage datalib:input_validate {scratch:{bad:1b}} run data modify storage datalib:input_validate result.valid set value 1b
execute if data storage datalib:input_validate {scratch:{bad:1b}} run data modify storage datalib:input_validate result.error set value "contains a disallowed character (space, quote, brace, bracket, colon, or backslash)"

data remove storage datalib:input_validate scratch.bad
