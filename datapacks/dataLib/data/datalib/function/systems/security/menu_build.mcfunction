# datalib:systems/security/menu_build [1.21.6 OVERLAY — MACRO]
# Called by menu.mcfunction with storage datalib:input {}.
# Builds the dialog with runtime values injected via macro ($).
#
# INPUT (macro args from datalib:input):
#   $(sandbox) — 0b / 1b
#   $(trust_players) — 0b / 1b
#   $(cmd_min_level) — int
#   $(sandbox_lvl) — int
#   $(admin_min_level) — int
#   $(admin_override) — 0b / 1b
#   $(perm_level) — int (caller's dl.perm_level)
data modify storage datalib:engine dialog.DIALOG set value {type:"minecraft:multi_action",title:{text:"DL Security",color:"#00AAAA",bold:1b},body:{type:"minecraft:plain_message",contents:"sandbox: $(sandbox) trust_players: $(trust_players)cmd_min_level: $(cmd_min_level) sandbox_level: $(sandbox_lvl)admin_min_level: $(admin_min_level) admin_override: $(admin_override)Your perm_level: $(perm_level)"},inputs:[{type:"minecraft:boolean",key:"sb",label:"Sandbox",initial:1b,on_true:"1b",on_false:"0b"}],actions:[{label:{text:"Refresh",color:"aqua",italic:0b},action:{type:"minecraft:run_command",command:"/function datalib:systems/security/menu"}}],pause:0b,can_close_with_escape:1b,after_action:"none"}
$data modify storage datalib:engine dialog.DIALOG.actions append value {label:{text:"Toggle Sandbox",color:"green",italic:0b},action:{type:"minecraft:dynamic/run_command",template:"/data modify storage dataLib sandbox set value $(sb)"}}
function datalib:api/dialog/load