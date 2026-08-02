# ─────────────────────────────────────────────────────────────────
# datalib:modules/math/api/vec/dot
# Computes the dot product of two vectors. (ax*bx + ay*by + az*bz)
# Result is integer — no fractions. May overflow for large vectors.
#
# INPUT: ax, ay, az, bx, by, bz
# OUTPUT: datalib:output result (int)
# ─────────────────────────────────────────────────────────────────

function datalib:modules/math/internal/vec/dot_exec with storage datalib:engine _vec_dot_tmp
