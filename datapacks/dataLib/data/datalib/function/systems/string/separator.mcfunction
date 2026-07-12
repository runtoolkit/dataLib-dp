# ─────────────────────────────────────────────────────────────────
# datalib:systems/string/separator
# Sends a decorative horizontal separator line.
#  Input : $(target) → selector
#          $(color)  → line color (e.g. "gray", "aqua", "#555555")
#          $(label)  → optional center label (use "" for plain line)
#
# Example (plain line):
# data modify storage datalib:input target set value "@s"
# data modify storage datalib:input color set value "gray"
# data modify storage datalib:input label set value ""
# function datalib:systems/string/separator with storage datalib:input {}
#
# Example (labeled):
# data modify storage datalib:input label set value " Settings "
# function datalib:systems/string/separator with storage datalib:input {}
# ─────────────────────────────────────────────────────────────────

$tellraw $(target) ["",{"text":"──────────","color":"$(color)"},{"text":"$(label)","color":"$(color)","bold":true},{"text":"──────────","color":"$(color)"}]
