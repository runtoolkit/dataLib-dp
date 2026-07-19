# dl_load:main — Stage 0 Load Entry Point
#
# This is the ONLY function registered in the minecraft:load function tag
# (via datalib:load → dl_load:main).
# It does NOT load dataLib directly.
#
# Instead it delegates straight to the load gate, which broadcasts a
# clickable confirmation prompt, then returns. Nothing in datalib:engine
# storage is touched here.
#
# v6.0.1-pre2: renamed from dl_load:_ to dl_load:main, and dropped the
# marker-entity + 'say' broadcast pattern entirely.
#   - The marker/say pattern existed because 'say' has no @a[tag=...]
#     filter and, historically, tellraw/clickEvent rendering was
#     considered unreliable at server startup. tellraw @a does not
#     require an executing entity at all — there is no context reason
#     left to summon+kill a marker just to print a line.
#   - Every prompt below is now a clickable tellraw button using the
#     current run_command click event format: "click_event":
#     {"action":"run_command","command":"/function ..."}. See
#     dl_load:load/confirm for the actual button rendering.
#
# WHY DEFERRED LOAD (GATE SYSTEM):
#   - minecraft:load fires on /reload AND on world open.
#   - If datalib:engine storage contains live data from a prior session
#     (permissions, flags, wand binds, etc.), any unconditional storage
#     write causes silent overwrites and nondeterministic engine state.
#   - The gate requires explicit admin confirmation before any storage
#     touch.
#
# CONFIRMING:  /function dl_load:load/yes  (or click the button)
# CANCELLING:  /function dl_load:load/no   (or click the button)
# AUTO-CANCEL: fires after 5 minutes if no response

function dl_load:load/confirm
