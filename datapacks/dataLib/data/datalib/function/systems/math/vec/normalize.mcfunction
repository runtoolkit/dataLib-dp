# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/vec/normalize
# Scales vector to unit length (×1000 fixed-point).
# Length computed via math/distance3d (floor(√(x²+y²+z²))).
# Results are ×1000 — divide by 1000 before using as direction vector.
#
# INPUT: x, y, z
# OUTPUT: datalib:output {x, y, z, length}
# If length=0, zero vector — returns x,y,z=0.
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/math/vec/normalize_exec with storage datalib:input {}
