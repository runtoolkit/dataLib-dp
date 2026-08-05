# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/vec/cross
# Computes the cross product of two vectors.
# cx = ay*bz - az*by
# cy = az*bx - ax*bz
# cz = ax*by - ay*bx
#
# INPUT: ax, ay, az, bx, by, bz
# OUTPUT: datalib:output {x, y, z}
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/math/vec/cross_exec with storage datalib:input {}
