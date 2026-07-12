# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/fiber/spawn
# Starts a new fiber and immediately runs its first step.
# If spawned with the same id, the existing fiber is replaced.
#
# INPUT (storage datalib:input):
# id → fiber id (unique string)
# func → function name to start
#
# EXAMPLE:
# data modify storage datalib:input id set value "boss_intro"
# data modify storage datalib:input func set value "mypack:boss/step_0"
# function datalib:core/lib/fiber/spawn
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/core/lib/fiber/spawn_exec with storage datalib:input {}
