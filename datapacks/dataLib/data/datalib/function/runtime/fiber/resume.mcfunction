# ─────────────────────────────────────────────────────────────────
# datalib:runtime/fiber/resume
# Resumes a fiber immediately (no delay).
# Used to trigger a fiber step externally without yield.
#
# INPUT (storage datalib:input):
# id → fiber id
# func → function to run
# ─────────────────────────────────────────────────────────────────

function datalib:runtime/lib/internal/fiber/resume_exec with storage datalib:input {}
