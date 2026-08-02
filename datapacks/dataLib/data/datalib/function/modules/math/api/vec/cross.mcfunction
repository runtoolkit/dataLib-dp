# ─────────────────────────────────────────────────────────────────
# datalib:modules/math/api/vec/cross
# Computes the cross product of two vectors.
# cx = ay*bz - az*by
# cy = az*bx - ax*bz
# cz = ax*by - ay*bx
#
# INPUT: ax, ay, az, bx, by, bz
# OUTPUT: datalib:output {x, y, z}
# ─────────────────────────────────────────────────────────────────

function datalib:modules/math/internal/vec/cross_exec with storage datalib:input {}
