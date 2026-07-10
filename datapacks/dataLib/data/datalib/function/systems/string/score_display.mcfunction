# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/score_display
# Sends a formatted label: value line from a scoreboard objective.
#  Input : $(target)    → selector to receive the message
#          $(label)     → display label (e.g. "Points")
#          $(player)    → scoreboard player name (e.g. "@s", "<player name>")
#          $(objective) → scoreboard objective name
#          $(color)     → value color (e.g. "green", "gold")
#
# Example:
# data modify storage datalib:input target set value "@s"
# data modify storage datalib:input label set value "Points"
# data modify storage datalib:input player set value "@s"
# data modify storage datalib:input objective set value "myPoints"
# data modify storage datalib:input color set value "green"
# function datalib:systems/string/score_display with storage datalib:input {}
# # Output: "Points 42" (42 from scoreboard)
# ─────────────────────────────────────────────────────────────────

$tellraw $(target) ["",{"text":"$(label)","color":"gray"},{"text":"  ","color":"#555555"},{"score":{"name":"$(player)","objective":"$(objective)"},"color":"$(color)","bold":true}]
