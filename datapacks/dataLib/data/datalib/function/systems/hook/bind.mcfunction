# ─────────────────────────────────────────────────────────────────
# datalib:systems/hook/bind
# Binds a function or command to a specific event.
# Multiple binds can be added to the same event.
#
# INPUT (storage datalib:input):
# event → event name: "player_join" | "player_death" | "player_respawn"
# "level_up" | "block_place" | "block_break" | "item_use"
# func → (optional) function to run — as the triggering player
# cmd → (optional) command to run — used if func is absent
#
# EXAMPLE:
# data modify storage datalib:input event set value "player_death"
# data modify storage datalib:input func set value "mypack:on_death"
# function datalib:systems/hook/bind
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/hook/bind_exec with storage datalib:input {}
