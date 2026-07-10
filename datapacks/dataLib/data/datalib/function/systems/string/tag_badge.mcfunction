# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/tag_badge
# Sends a styled [TAG] badge with optional hover text.
#  Input : $(target)     → selector
#          $(tag)        → badge label (e.g. "ADMIN", "VIP")
#          $(color)      → badge color (e.g. "red", "gold")
#          $(hover)      → hover tooltip text
#
# Example:
# data modify storage datalib:input target set value "@s"
# data modify storage datalib:input tag set value "ADMIN"
# data modify storage datalib:input color set value "red"
# data modify storage datalib:input hover set value "Server Administrator"
# function datalib:systems/string/tag_badge with storage datalib:input {}
# ─────────────────────────────────────────────────────────────────

$tellraw $(target) ["",{"text":"[","color":"#555555","bold":false},{"text":"$(tag)","color":"$(color)","bold":true,"hover_event":{"action":"show_text","value":{"text":"$(hover)","color":"gray","italic":true}}},{"text":"]","color":"#555555","bold":false}]
