# datalib:api/interaction/bind_attack
# Binds a function to an interaction entity attack event.
#
# INPUT:
#   datalib:input tag  — entity tag to match
#   datalib:input func — function to call on attack
#
# USAGE:
#   data modify storage datalib:input tag set value "my_interact"
#   data modify storage datalib:input func set value "mypack:on_attack"
#   function datalib:api/interaction/bind_attack with storage datalib:input {}
function datalib:core/internal/api/interaction/bind_attack_do with storage datalib:input {}
