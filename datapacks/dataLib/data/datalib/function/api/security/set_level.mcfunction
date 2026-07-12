# ─────────────────────────────────────────────────────────────────
# datalib:api/security/set_level [MACRO]
# Sets a player's dl.perm_level scoreboard value.
#
# INPUT (macro args):
#   $(player) — exact player name
#   $(level)  — integer level (0=none, 1=basic, 2=standard,
#                3=elevated/$$(cmd), 4=super)
#
# EXAMPLE:
#   function datalib:api/security/set_level {player:"Steve",level:3}
#
# LEVELS:
#   0  No access (default for new players)
#   1  Basic — may use cmd/ functions that only require admin_min_level=1
#   2  Standard — full cmd/ access (default admin_min_level)
#   3  Elevated — may also trigger $$(cmd) execution
#   4  Super — may trigger $$(cmd) even in sandbox mode
#
# NOTE: admin_can_override:0b means even level-4 users are subject
#       to the security.sandbox_cmd_min_level floor.
# ─────────────────────────────────────────────────────────────────
$execute as @a[name=$(player),limit=1] run scoreboard players set @s dl.perm_level $(level)
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"security/set_level ","color":"aqua"},{"text":"$(player)","color":"gold"},{"text":" → ","color":"#555555"},{"text":"$(level)","color":"green"}]
