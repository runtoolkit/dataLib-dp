# ─────────────────────────────────────────────────────────────────
# datalib:systems/hook/on_advancement_fire
# Called from the user's own advancement reward function.
# Fires an event in "advancement:<id>" format.
#
# INPUT (storage datalib:input):
# advancement → advancement ID (e.g. "story/mine_stone")
#
# KULLANIM:
# 1) Define a function as the reward in your advancement JSON:
# "rewards": {"function": "mypack:advancements/mine_stone"}
#
# 2) Inside that function:
# data modify storage datalib:input advancement set value "story/mine_stone"
# function datalib:systems/hook/on_advancement_fire
#
# 3) Hook bind:
# data modify storage datalib:input event set value "advancement:story/mine_stone"
# data modify storage datalib:input func set value "mypack:on_first_mine"
# function datalib:systems/hook/bind
# ─────────────────────────────────────────────────────────────────

function datalib:core/internal/systems/hook/on_advancement_fire with storage datalib:engine {}
