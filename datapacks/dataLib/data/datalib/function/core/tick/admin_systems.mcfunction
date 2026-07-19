# Auto-grant datalib.debug to admins — configurable via
# datalib:engine security.auto_debug_tag (default 1b, legacy behavior).
# Set to 0b to require explicit debug-tag management instead:
#   /function datalib:debug/tools/admin/debug_tag/enable
#   /function datalib:debug/tools/admin/debug_tag/disable
execute if data storage datalib:engine security{auto_debug_tag:1b} run tag @a[tag=datalib.admin] add datalib.debug

scoreboard players enable @a[tag=datalib.admin] dl_menu
scoreboard players enable @a[tag=datalib.admin] dl_action
scoreboard players enable @a[tag=datalib.admin] dl_run
function datalib:core/internal/systems/geo/region_watch/tick_scan
