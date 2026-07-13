# ─────────────────────────────────────────────────────────────────
# datalib:core/lib/fiber/resume
# Resumes a fiber immediately (no delay).
# Used to trigger a fiber step externally without yield.
#
# INPUT (storage datalib:input):
# id → fiber id
# func → function to run
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/core/lib/fiber/resume_exec with storage datalib:input {}
