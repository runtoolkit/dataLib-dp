# datalib:debug/tools/trigger/internal/dispatch
# Calls datalib:api/cmd/* based on tools_trigger.type.
# All calls use "with storage datalib:engine tools_trigger.data".

# ── Message ──────────────────────────────────────────────────────────────────
# type:"msg" → data:{player:"Name", message:"..."}
execute if data storage datalib:engine tools_trigger{type:"msg"} run function datalib:api/cmd/msg with storage datalib:engine tools_trigger.data

# type:"title" → data:{player:"Name", text:"...", color:"gold"}
execute if data storage datalib:engine tools_trigger{type:"title"} run function datalib:api/cmd/title with storage datalib:engine tools_trigger.data

# type:"subtitle" → data:{player:"Name", text:"...", color:"white"}
execute if data storage datalib:engine tools_trigger{type:"subtitle"} run function datalib:api/cmd/subtitle with storage datalib:engine tools_trigger.data

# type:"actionbar" → data:{player:"Name", text:"...", color:"aqua"}
execute if data storage datalib:engine tools_trigger{type:"actionbar"} run function datalib:api/cmd/actionbar with storage datalib:engine tools_trigger.data

# type:"title_times"→ data:{player:"Name", in:10, stay:70, out:20}
execute if data storage datalib:engine tools_trigger{type:"title_times"} run function datalib:api/cmd/title_times with storage datalib:engine tools_trigger.data

# type:"title_clear"→ data:{player:"Name"}
execute if data storage datalib:engine tools_trigger{type:"title_clear"} run function datalib:api/cmd/title_clear with storage datalib:engine tools_trigger.data

# type:"title_reset"→ data:{player:"Name"}
execute if data storage datalib:engine tools_trigger{type:"title_reset"} run function datalib:api/cmd/title_reset with storage datalib:engine tools_trigger.data

# ── Sound & Particles ──────────────────────────────────────────────────────
# type:"sound" → data:{player:"Name", sound:"minecraft:...", volume:1, pitch:1}
execute if data storage datalib:engine tools_trigger{type:"sound"} run function datalib:api/cmd/sound with storage datalib:engine tools_trigger.data

# ── Efekt ─────────────────────────────────────────────────────────────────
# type:"effect_add" → data:{player:"Name", effect:"minecraft:speed", duration:100, amplifier:1}
execute if data storage datalib:engine tools_trigger{type:"effect_add"} run function datalib:api/cmd/effect_give with storage datalib:engine tools_trigger.data

# type:"effect_clear"→ data:{player:"Name"}
execute if data storage datalib:engine tools_trigger{type:"effect_clear"} run function datalib:api/cmd/effect_clear with storage datalib:engine tools_trigger.data

# ── Item ──────────────────────────────────────────────────────────────────
# type:"give" → data:{player:"Name", item:"minecraft:diamond", count:1}
execute if data storage datalib:engine tools_trigger{type:"give"} run function datalib:api/cmd/give with storage datalib:engine tools_trigger.data

# ── XP ────────────────────────────────────────────────────────────────────
# type:"xp" → data:{player:"Name", amount:100, type:"points"} (type: points|levels)
execute if data storage datalib:engine tools_trigger{type:"xp"} run function datalib:api/cmd/xp_add with storage datalib:engine tools_trigger.data

# ── Oyuncu ────────────────────────────────────────────────────────────────
# type:"gamemode" → data:{player:"Name", mode:"survival"}
execute if data storage datalib:engine tools_trigger{type:"gamemode"} run function datalib:api/cmd/gamemode with storage datalib:engine tools_trigger.data

# type:"kick" → data:{player:"Name"}
execute if data storage datalib:engine tools_trigger{type:"kick"} run function datalib:api/cmd/kick with storage datalib:engine tools_trigger.data

# type:"tp" → data:{player:"Name", x:0, y:64, z:0}
execute if data storage datalib:engine tools_trigger{type:"tp"} run function datalib:api/cmd/tp_to_coords with storage datalib:engine tools_trigger.data

# ── Scoreboard ────────────────────────────────────────────────────────────
# type:"score_set" → data:{player:"Name", objective:"obj", value:10}
execute if data storage datalib:engine tools_trigger{type:"score_set"} run function datalib:api/cmd/scoreboard_set with storage datalib:engine tools_trigger.data

# type:"score_add" → data:{player:"Name", objective:"obj", amount:5}
execute if data storage datalib:engine tools_trigger{type:"score_add"} run function datalib:api/cmd/scoreboard_add with storage datalib:engine tools_trigger.data

# ── Tag ───────────────────────────────────────────────────────────────────
# type:"tag_add" → data:{player:"Name", tag:"myTag"}
execute if data storage datalib:engine tools_trigger{type:"tag_add"} run function datalib:api/cmd/tag_add with storage datalib:engine tools_trigger.data

# type:"tag_remove" → data:{player:"Name", tag:"myTag"}
execute if data storage datalib:engine tools_trigger{type:"tag_remove"} run function datalib:api/cmd/tag_remove with storage datalib:engine tools_trigger.data

# ── World ─────────────────────────────────────────────────────────────────
# type:"fill" → data:{x1:..,y1:..,z1:..,x2:..,y2:..,z2:..,block:"minecraft:stone"}
execute if data storage datalib:engine tools_trigger{type:"fill"} run function datalib:api/cmd/fill with storage datalib:engine tools_trigger.data

# type:"setblock" → data:{x:..,y:..,z:..,block:"minecraft:stone"}
execute if data storage datalib:engine tools_trigger{type:"setblock"} run function datalib:api/cmd/setblock with storage datalib:engine tools_trigger.data

# ── Fonksiyon & Komut ─────────────────────────────────────────────────────
# NOTE: delay / schedule_cancel intentionally excluded here.
# The schedule command runs at op-level; allowing arbitrary function scheduling.
# Use datalib:core/lib/schedule directly and explicitly if needed.
# type:"func" → data:{ns:"namespace", path:"func/path"}
execute if data storage datalib:engine tools_trigger{type:"func"} run function datalib:core/internal/debug/tools/trigger/exec_func with storage datalib:engine tools_trigger.data

# type:"cmd" → data:{cmd:"say hello"}
execute if data storage datalib:engine tools_trigger{type:"cmd"} run function datalib:core/internal/debug/tools/trigger/exec_cmd with storage datalib:engine tools_trigger.data

# type:"multi1" → data:{list:[],options:{}}
execute if data storage datalib:engine tools_trigger{type:"multi1"} run function datalib:api/cmd/other/multi_cmd_adv with storage datalib:engine tools_trigger.data

# type:"multi2" → data:{commands:[]}
execute if data storage datalib:engine tools_trigger{type:"multi2"} run function datalib:api/cmd/other/multi_cmd with storage datalib:engine tools_trigger.data
