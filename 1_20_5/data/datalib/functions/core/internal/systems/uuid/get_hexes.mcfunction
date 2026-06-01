# ============================================================
# datalib:core/internal/systems/uuid/get_hexes [MACRO FUNCTION]
# Converts 16 byte ints in datalib:uuid _tmp to 2-character hex strings
#
# Call: function datalib:core/internal/systems/uuid/get_hexes with storage datalib:uuid _tmp
# Fields 0..f are used as indices into the hex lookup table.
# The same fields are overwritten with hex string results.
# ============================================================
$data modify storage datalib:uuid _tmp.0 set from storage datalib:uuid hex_chars[$(0)]
$data modify storage datalib:uuid _tmp.1 set from storage datalib:uuid hex_chars[$(1)]
$data modify storage datalib:uuid _tmp.2 set from storage datalib:uuid hex_chars[$(2)]
$data modify storage datalib:uuid _tmp.3 set from storage datalib:uuid hex_chars[$(3)]
$data modify storage datalib:uuid _tmp.4 set from storage datalib:uuid hex_chars[$(4)]
$data modify storage datalib:uuid _tmp.5 set from storage datalib:uuid hex_chars[$(5)]
$data modify storage datalib:uuid _tmp.6 set from storage datalib:uuid hex_chars[$(6)]
$data modify storage datalib:uuid _tmp.7 set from storage datalib:uuid hex_chars[$(7)]
$data modify storage datalib:uuid _tmp.8 set from storage datalib:uuid hex_chars[$(8)]
$data modify storage datalib:uuid _tmp.9 set from storage datalib:uuid hex_chars[$(9)]
$data modify storage datalib:uuid _tmp.a set from storage datalib:uuid hex_chars[$(a)]
$data modify storage datalib:uuid _tmp.b set from storage datalib:uuid hex_chars[$(b)]
$data modify storage datalib:uuid _tmp.c set from storage datalib:uuid hex_chars[$(c)]
$data modify storage datalib:uuid _tmp.d set from storage datalib:uuid hex_chars[$(d)]
$data modify storage datalib:uuid _tmp.e set from storage datalib:uuid hex_chars[$(e)]
$data modify storage datalib:uuid _tmp.f set from storage datalib:uuid hex_chars[$(f)]
