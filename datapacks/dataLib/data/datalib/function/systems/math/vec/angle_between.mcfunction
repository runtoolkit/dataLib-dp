# ─────────────────────────────────────────────────────────────────
# datalib:systems/math/vec/angle_between
# Returns the angle between two vectors in degrees.
# cos(θ) = dot(A,B) / (|A| × |B|) → θ = arccos(...)
# Uses ×1000 fixed-point cos table for arccos.
#
# INPUT: ax, ay, az, bx, by, bz
# OUTPUT: datalib:output result (0–180, integer degrees)
# result=0 for zero vectors.
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/math/vec/angle_exec with storage datalib:input {}
