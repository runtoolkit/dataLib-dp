# ============================================================
# datalib:systems/uuid/internal/extract_bytes
# Splits 4 UUID ints into 16 bytes (correct signed integer arithmetic)
#
# REQUIREMENT: The following fake-player scores must be set:
# $uuid.0 $uuid.1 $uuid.2 $uuid.3 dl.tmp
# $uuid.256 dl.tmp = 256 (set by init)
#
# OUTPUT: storage datalib:uuid _tmp
# Fields 0..3 → bytes of int 0 (0=LSB, 3=MSB)
# Fields 4..7 → bytes of int 1
# Fields 8..b → bytes of int 2
# Fields c..f → bytes of int 3
# Each field is guaranteed to be in range 0–255.
#
# NEDEN GU'DAN FARKLI?
# Java's `/` operator truncates toward zero for negative dividends.
# Example: -1 / 256 = 0 (floor should be -1).
# GU does not handle this; high bytes of negative ints are computed incorrectly.
# This function correctly extracts each byte using floor-division:
#
# b_raw = v % 256 (Java mod, range -255..255)
# if b_raw < 0:
# v = (v / 256) - 1 (correction for floor division)
# b = b_raw + 256 (normalize to 0..255)
# else:
# v = v / 256
# b = b_raw
# ============================================================

# --- INT 0 (first 4 bytes of UUID, fields 0..3) ---

# byte 0 — LSB
scoreboard players operation $uuid.a dl.tmp = $uuid.0 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.0 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.0 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.0 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 1
scoreboard players operation $uuid.a dl.tmp = $uuid.0 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.0 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.0 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.1 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 2
scoreboard players operation $uuid.a dl.tmp = $uuid.0 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.0 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.0 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.2 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 3 — MSB (last byte, no division)
scoreboard players operation $uuid.a dl.tmp = $uuid.0 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.3 int 1 run scoreboard players get $uuid.a dl.tmp

# --- INT 1 (alanlar 4..7) ---

# byte 0 — LSB
scoreboard players operation $uuid.a dl.tmp = $uuid.1 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.1 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.1 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.4 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 1
scoreboard players operation $uuid.a dl.tmp = $uuid.1 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.1 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.1 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.5 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 2
scoreboard players operation $uuid.a dl.tmp = $uuid.1 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.1 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.1 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.6 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 3 — MSB
scoreboard players operation $uuid.a dl.tmp = $uuid.1 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.7 int 1 run scoreboard players get $uuid.a dl.tmp

# --- INT 2 (alanlar 8..b) ---

# byte 0 — LSB
scoreboard players operation $uuid.a dl.tmp = $uuid.2 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.2 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.2 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.8 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 1
scoreboard players operation $uuid.a dl.tmp = $uuid.2 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.2 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.2 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.9 int 1 run scoreboard players get $uuid.a dl.tmp

# byte 2
scoreboard players operation $uuid.a dl.tmp = $uuid.2 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.2 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.2 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.a int 1 run scoreboard players get $uuid.a dl.tmp

# byte 3 — MSB
scoreboard players operation $uuid.a dl.tmp = $uuid.2 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.b int 1 run scoreboard players get $uuid.a dl.tmp

# --- INT 3 (alanlar c..f) ---

# byte 0 — LSB
scoreboard players operation $uuid.a dl.tmp = $uuid.3 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.3 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.3 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.c int 1 run scoreboard players get $uuid.a dl.tmp

# byte 1
scoreboard players operation $uuid.a dl.tmp = $uuid.3 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.3 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.3 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.d int 1 run scoreboard players get $uuid.a dl.tmp

# byte 2
scoreboard players operation $uuid.a dl.tmp = $uuid.3 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
scoreboard players operation $uuid.3 dl.tmp /= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players remove $uuid.3 dl.tmp 1
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.e int 1 run scoreboard players get $uuid.a dl.tmp

# byte 3 — MSB
scoreboard players operation $uuid.a dl.tmp = $uuid.3 dl.tmp
scoreboard players operation $uuid.a dl.tmp %= $uuid.256 dl.tmp
execute if score $uuid.a dl.tmp matches ..-1 run scoreboard players add $uuid.a dl.tmp 256
execute store result storage datalib:uuid _tmp.f int 1 run scoreboard players get $uuid.a dl.tmp
