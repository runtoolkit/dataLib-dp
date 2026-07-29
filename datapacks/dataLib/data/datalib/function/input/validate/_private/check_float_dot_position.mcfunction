# ======================================================================================
# datalib:input/validate/_private/check_float_dot_position  [INTERNAL]
# ======================================================================================
# stringlib:output find holds a one-element list [idx] for the '.' just
# located by check_float. Rejects idx == 0 (leading dot, e.g. ".5") and
# idx == len-1 (trailing dot, e.g. "1.") as malformed rather than
# guessing an implied leading/trailing zero.
# ======================================================================================

execute store result score #DL.DotIdx dl.tmp run data get storage stringlib:output find[0]
execute store result score #DL.Len dl.tmp run data get storage datalib:input_validate scratch.rest

scoreboard players operation #DL.LastIdx dl.tmp = #DL.Len dl.tmp
scoreboard players remove #DL.LastIdx dl.tmp 1

execute if score #DL.DotIdx dl.tmp matches 0 run data modify storage datalib:input_validate result.error set value "malformed decimal point"
execute if score #DL.DotIdx dl.tmp = #DL.LastIdx dl.tmp run data modify storage datalib:input_validate result.error set value "malformed decimal point"
