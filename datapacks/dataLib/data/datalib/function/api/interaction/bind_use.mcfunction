# datalib:api/interaction/bind_use
# Binds a function to an interaction entity use (right-click) event.
#
# INPUT:
#   datalib:input tag  — entity tag to match
#   datalib:input func — function to call on use
#
# USAGE:
#   data modify storage datalib:input tag set value "my_interact"
#   data modify storage datalib:input func set value "mypack:on_use"
#   function datalib:api/interaction/bind_use with storage datalib:input {}
function datalib:core/internal/api/interaction/bind_use_do with storage datalib:input {}
