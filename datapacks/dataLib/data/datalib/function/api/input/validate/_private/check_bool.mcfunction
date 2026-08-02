# ======================================================================================
# datalib:api/input/validate/_private/check_bool  [INTERNAL]
# ======================================================================================
# Requires scratch.value to be the exact string "true" or "false". No
# case-folding — "True"/"TRUE" are rejected on purpose, since silently
# accepting them just moves the ambiguity one step further down instead
# of resolving it.
# ======================================================================================

execute if data storage datalib:input_validate {scratch:{value:"true"}} run data modify storage datalib:input_validate result.valid set value 1b
execute if data storage datalib:input_validate {scratch:{value:"false"}} run data modify storage datalib:input_validate result.valid set value 1b

execute unless data storage datalib:input_validate {result:{valid:1b}} run data modify storage datalib:input_validate result.error set value "expected exactly \"true\" or \"false\""
