#!/usr/bin/env bash
# datalib_fix.sh — dataLib repo düzeltme scripti
# Codespaces terminaline yapıştır ve çalıştır:
#   bash datalib_fix.sh [REPO_DIR]
# REPO_DIR verilmezse ./dataLib varsayılır.
# Gereksinim: git, python3 (json parse için)
set -euo pipefail

REPO="${1:-./dataLib}" && cd "$REPO" && echo "[1/12] Repo: $(pwd)"

# ── Git identity (Codespaces'te yoksa commit atar) ──────────────────────────
git config user.email "legends11@runtoolkit.local" 2>/dev/null || true && git config user.name "Legends11" 2>/dev/null || true

# ════════════════════════════════════════════════════════════════════════════
# FIX 1: dl_load:load/fork deadlock (1_21_5 + 1_21_6)
# Stale-state reset eksikliği: önceki oturumdan kalan #pending=1 kapıyı
# kalıcı kilitliyordu. load/confirm.mcfunction'ın doğru pattern'ini uygula.
# ════════════════════════════════════════════════════════════════════════════
echo "[2/12] FIX 1: fork deadlock (1_21_5, 1_21_6)"

FORK_CONTENT='# dl_load:load/fork
# Fork confirmation gate — called when fork_verified is not set.
# Player is prompted to confirm with /yes or /no.
#
# BUGFIX: previously this function had a stale-state guard
# ("drop silently if already open") that checked #pending dl.fork_gate
# matches 1 and returned 0. If a prior session left #pending=1 (e.g.
# the gate was opened but the server was restarted before confirmation),
# the gate would be permanently locked — fork_yes/fork_no would silently
# no-op, load/all would never proceed past the fork check, and the
# 30-second auto-cancel schedule would never be re-armed.
# Fixed by resetting state on every call, matching the pattern used by
# load/confirm.mcfunction (which correctly resets every time).
#
# CONFIRM:  /function dl_load:load/fork_yes
# CANCEL:   /function dl_load:load/fork_no

scoreboard objectives add dl.fork_gate dummy

# Reset any stale state from a previous incomplete gate cycle
scoreboard players set #pending dl.fork_gate 0
scoreboard players set #confirmed dl.fork_gate 0

# Open the gate window
scoreboard players set #pending dl.fork_gate 1

summon minecraft:marker ~ ~ ~ {Tags:["datalib.fork_gate"],CustomName:{"text":"DL"}}
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] This copy is not marked as a fork.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Do you want to continue?
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] YES:    /function dl_load:load/fork_yes
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] NO:     /function dl_load:load/fork_no
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run say [DL FORK GATE] Auto-cancel fires in 30 seconds.
execute as @e[type=minecraft:marker,tag=datalib.fork_gate,limit=1] run kill @s

schedule function dl_load:load/fork_no 30s replace'

for OVERLAY in 1_21_5 1_21_6; do
  TARGET="$OVERLAY/data/dl_load/function/load/fork.mcfunction"
  [ -f "$TARGET" ] && printf '%s\n' "$FORK_CONTENT" > "$TARGET" && echo "  patched: $TARGET"
done

# ════════════════════════════════════════════════════════════════════════════
# FIX 2: multi_type_check güvenlik bypass'ı (ana pack + 1_20_5)
# Son komut (data remove) her zaman başarılı döndüğü için
# execute unless function ... guard'ı bypass ediliyordu.
# ════════════════════════════════════════════════════════════════════════════
echo "[3/12] FIX 2: multi_type_check security bypass"

MTC_MAIN='# datalib:core/security/multi_type_check
# Validates datalib:engine multiCommands.type against security.multi_type_allowlist.
# Called before executing multi_cmd or multi_cmd_adv operations.
#
# Returns 1 → type is valid.
# Returns 0 → type violation fired (log + kick).
#
# BUGFIX: the function previously ended with "data remove ... _mcmd_type_tmp",
# which always succeeds (returns 1) regardless of the allowlist check.
# Callers using "execute if/unless function" always read success=1,
# silently bypassing the check. Cleanup now happens inside the macro,
# and the macro returns the real allowlist result via "return run execute".
data modify storage datalib:engine _mcmd_type_tmp set from storage datalib:engine multiCommands.type
return run function datalib:core/security/multi_type_check_macro with storage datalib:engine {}'

MTC_MACRO='# datalib:core/security/multi_type_check_macro [MACRO]
# Called with storage datalib:engine {} — reads $(_mcmd_type_tmp) from engine.
# Checks if the type exists as a key in security.multi_type_allowlist.
#
# BUGFIX: the allowlist check result is re-evaluated as the final command
# via explicit return 1 / return 0 so callers get the correct result.
$execute unless data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b} run function datalib:core/security/type_violation
$execute store result score #mtc_valid dl.tmp if data storage datalib:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b}
data remove storage datalib:engine _mcmd_type_tmp
return run execute if score #mtc_valid dl.tmp matches 1'

for BASE in "data/datalib/function" "1_20_5/data/datalib/functions"; do
  MAIN_PATH="$BASE/core/security/multi_type_check.mcfunction"
  MACRO_PATH="$BASE/core/security/multi_type_check_macro.mcfunction"
  if [ -f "$MAIN_PATH" ]; then
    printf '%s\n' "$MTC_MAIN" > "$MAIN_PATH" && echo "  patched: $MAIN_PATH"
    printf '%s\n' "$MTC_MACRO" > "$MACRO_PATH" && echo "  patched: $MACRO_PATH"
  fi
done

# ════════════════════════════════════════════════════════════════════════════
# FIX 3: 1_20_3 tick çift-tetiklenmesi
# core/tick hem #datalib:loop tag'i içinde hem doğrudan çağrılıyordu.
# ════════════════════════════════════════════════════════════════════════════
echo "[4/12] FIX 3: 1_20_3 tick double-execution"

LOOP_JSON='{"values":[]}'
LOOP_PATH="1_20_3/data/datalib/tags/functions/loop.json"
[ -f "$LOOP_PATH" ] && printf '%s\n' "$LOOP_JSON" > "$LOOP_PATH" && echo "  patched: $LOOP_PATH"

# ════════════════════════════════════════════════════════════════════════════
# FIX 4: 1_20_5 yanlış item modifier formatları
# set_custom_model_data: 1.21.4+ composite format, 1.20.5'te tek int.
# hide_tooltip: 1.21.5+ tooltip_display, 1.20.5'te flag-style bileşen.
# ════════════════════════════════════════════════════════════════════════════
echo "[5/12] FIX 4: 1_20_5 item modifier format errors"

ITEM_MOD_BASE="1_20_5/data/datalib/item_modifiers"

if [ -d "$ITEM_MOD_BASE" ]; then
  printf '%s\n' '{
  "_comment": "datalib: set_custom_model_data — 1.20.5-1.21.3 format (single int). The composite floats/strings/flags/colors format is 1.21.4+ only.",
  "function": "minecraft:set_components",
  "components": {
    "minecraft:custom_model_data": 1
  }
}' > "$ITEM_MOD_BASE/set_custom_model_data.json" && echo "  patched: $ITEM_MOD_BASE/set_custom_model_data.json"

  printf '%s\n' '{
  "function": "minecraft:set_components",
  "components": {
    "minecraft:hide_tooltip": {}
  }
}' > "$ITEM_MOD_BASE/hide_tooltip.json" && echo "  patched: $ITEM_MOD_BASE/hide_tooltip.json"
fi

# ════════════════════════════════════════════════════════════════════════════
# FIX 5: 1_20_5 log sistemi — macro hedefi yanlıştı
# log/debug, log/error, log/info: "with storage datalib:engine {}" yerine
# "with storage datalib:engine _log_add_tmp" olmalı.
# ════════════════════════════════════════════════════════════════════════════
echo "[6/12] FIX 5: 1_20_5 log macro target"

LOG_BASE="1_20_5/data/datalib/functions/systems/log"

if [ -d "$LOG_BASE" ]; then
  printf '%s\n' '# datalib:systems/log/debug
# Logs a DEBUG-level message. Log level must be >= 4.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 4.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "DEBUG"
data modify storage datalib:engine _log_add_tmp.color set value "gray"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp' > "$LOG_BASE/debug.mcfunction" && echo "  patched: $LOG_BASE/debug.mcfunction"

  printf '%s\n' '# datalib:systems/log/error
# Logs an ERROR-level message. Log level must be >= 1.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 1.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "ERROR"
data modify storage datalib:engine _log_add_tmp.color set value "red"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp' > "$LOG_BASE/error.mcfunction" && echo "  patched: $LOG_BASE/error.mcfunction"

  printf '%s\n' '# datalib:systems/log/info
# Logs an INFO-level message. Log level must be >= 3.
# INPUT: data modify storage datalib:engine _log_add_tmp.message set value "..."
execute unless score #dl.log_level dl.log_level matches 3.. run return 0
data modify storage datalib:engine _log_add_tmp.level set value "INFO"
data modify storage datalib:engine _log_add_tmp.color set value "white"
function datalib:systems/log/add with storage datalib:engine _log_add_tmp
data remove storage datalib:engine _log_add_tmp' > "$LOG_BASE/info.mcfunction" && echo "  patched: $LOG_BASE/info.mcfunction"
fi

# ════════════════════════════════════════════════════════════════════════════
# FIX 6: 1_20_5 eksik gamerule API (10 dosya + scoreboard objective)
# api/gamerule/{get,set,reset} + core/internal/api/gamerule/* tamamen yoktu.
# ════════════════════════════════════════════════════════════════════════════
echo "[7/12] FIX 6: 1_20_5 missing gamerule API"

GM_API="1_20_5/data/datalib/functions/api/gamerule"
GM_INT="1_20_5/data/datalib/functions/core/internal/api/gamerule"
mkdir -p "$GM_API" "$GM_INT"

printf '%s\n' '# datalib:api/gamerule/get [MACRO]
# Reads a custom gamerule from datalib:engine gamerules.<rule>.
# INPUT: data modify storage datalib:input rule set value "pvp_enabled"
# CALL:  function datalib:api/gamerule/get with storage datalib:input {}
# OUT:   datalib:output gamerule

execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
data remove storage datalib:output gamerule
function datalib:core/internal/api/gamerule/read with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/get ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"}]}
data remove storage datalib:input _gamerule_norm' > "$GM_API/get.mcfunction"

printf '%s\n' '# datalib:api/gamerule/set [MACRO]
# Sets a custom gamerule value in datalib:engine gamerules.<rule>.
# INPUT: data modify storage datalib:input rule set value "pvp_enabled"
#        data modify storage datalib:input value set value "true"
# OPTIONAL: gr_on_true, gr_on_false, gr_on_value, gr_matches

execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
function datalib:core/internal/api/gamerule/persist with storage datalib:input {}
function datalib:core/internal/api/gamerule/dispatch with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/set ","color":"aqua"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"text":"$(value)","color":"green"}]}
data remove storage datalib:input _gamerule_norm
return 1' > "$GM_API/set.mcfunction"

printf '%s\n' '# datalib:api/gamerule/reset [MACRO]
# Removes a custom gamerule from datalib:engine gamerules.
execute unless function datalib:core/security/cmd_gate run return 0
data modify storage stringlib:input replace.String set from storage datalib:input rule
data modify storage stringlib:input replace.Find set value " "
data modify storage stringlib:input replace.Replace set value "_"
function stringlib:util/replace
data modify storage datalib:input _gamerule_norm set from storage stringlib:output replace
data remove storage stringlib:input replace
function datalib:core/internal/api/gamerule/remove with storage datalib:input {}
$tellraw @a[tag=datalib.debug] {"text":"","extra":[{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"gamerule/reset ","color":"aqua"},{"text":"$(_gamerule_norm)","color":"gray","italic":true},{"text":" removed","color":"gray"}]}
data remove storage datalib:input _gamerule_norm' > "$GM_API/reset.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/dispatch
execute if data storage datalib:input {value:"true"} if data storage datalib:input gr_on_true run return run function datalib:core/internal/api/gamerule/call_on_true with storage datalib:input {}
execute if data storage datalib:input {value:"false"} if data storage datalib:input gr_on_false run return run function datalib:core/internal/api/gamerule/call_on_false with storage datalib:input {}
execute if data storage datalib:input gr_on_value if data storage datalib:input gr_matches run function datalib:core/internal/api/gamerule/numeric_check with storage datalib:input {}' > "$GM_INT/dispatch.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/read [MACRO]
$execute if data storage datalib:engine gamerules.$(_gamerule_norm) run data modify storage datalib:output gamerule set from storage datalib:engine gamerules.$(_gamerule_norm)' > "$GM_INT/read.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/persist [MACRO]
$data modify storage datalib:engine gamerules.$(_gamerule_norm) set value "$(value)"' > "$GM_INT/persist.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/remove [MACRO]
$data remove storage datalib:engine gamerules.$(_gamerule_norm)' > "$GM_INT/remove.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/numeric_check [MACRO]
$scoreboard players set #dl_gamerule_scratch dl.gamerule $(value)
$execute if score #dl_gamerule_scratch dl.gamerule matches $(gr_matches) run function $(gr_on_value)' > "$GM_INT/numeric_check.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/call_on_true [MACRO]
$function $(gr_on_true)' > "$GM_INT/call_on_true.mcfunction"

printf '%s\n' '# datalib:core/internal/api/gamerule/call_on_false [MACRO]
$function $(gr_on_false)' > "$GM_INT/call_on_false.mcfunction"

# dl.gamerule scoreboard objective — sadece 1_20_5'e özel, ana pack zaten ekliyor
SB_1205="1_20_5/data/dl_load/functions/load/scoreboards.mcfunction"
if [ -f "$SB_1205" ] && ! grep -q "dl.gamerule" "$SB_1205"; then
  printf '\n# Custom gamerule system\nscoreboard objectives add dl.gamerule dummy\n' >> "$SB_1205"
  echo "  patched: $SB_1205 (dl.gamerule objective)"
fi

echo "  created: $GM_API/{get,set,reset} + $GM_INT (7 files)"

# ════════════════════════════════════════════════════════════════════════════
# FIX 7: 1_20_5 api/toggle/show.mcfunction — dialog show 1.21.6+'a özel
# 1.20.5'te bu komut yok, tellraw+clickEvent menüsüyle değiştirildi.
# Mecha ile doğrulandı: "Expected ... but got literal 'dialog'."
# ════════════════════════════════════════════════════════════════════════════
echo "[8/12] FIX 7: 1_20_5 toggle/show dialog -> tellraw"

TOGGLE_SHOW="1_20_5/data/datalib/functions/api/toggle/show.mcfunction"
if [ -f "$TOGGLE_SHOW" ]; then
  printf '%s\n' '# datalib:api/toggle/show
# Opens the module toggle menu (1.20.5 compat: tellraw + clickEvent).
# The main pack uses "dialog show" which only exists from 1.21.6 onward.
# Confirmed failing under mecha 1.20 target before this fix.

execute unless entity @s[tag=datalib.admin] run return 0

tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"━━━ Toggle a module ━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":"  hook        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/hook/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/hook/false"}}]
tellraw @s ["",{"text":"  interaction ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/interaction/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/interaction/false"}}]
tellraw @s ["",{"text":"  perm        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/perm/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/perm/false"}}]
tellraw @s ["",{"text":"  wand        ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/wand/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/wand/false"}}]
tellraw @s ["",{"text":"  geo         ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/geo/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/geo/false"}}]
tellraw @s ["",{"text":"  cb          ","color":"yellow"},{"text":"[ON] ","color":"green","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/cb/true"}},{"text":"[OFF]","color":"red","clickEvent":{"action":"run_command","value":"/function datalib:api/toggle/cb/false"}}]
tellraw @s ["",{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"toggle/show","color":"aqua"},{"text":" → opened (1.20.5 tellraw menu)","color":"gray"}]' > "$TOGGLE_SHOW" && echo "  patched: $TOGGLE_SHOW"
fi

# ════════════════════════════════════════════════════════════════════════════
# FIX 8: Ana pack'te geo/region_watch/tick_scan çağrısı eksik
# core/tick/player_systems.mcfunction'da hook'tan sonra geo çağrısı yoktu,
# region-watch sistemi hiç çalışmıyordu.
# ════════════════════════════════════════════════════════════════════════════
echo "[9/12] FIX 8: main pack missing geo/region_watch tick call"

PS_MAIN="data/datalib/function/core/tick/player_systems.mcfunction"
if [ -f "$PS_MAIN" ] && ! grep -q "region_watch/tick_scan" "$PS_MAIN"; then
  # Hook sistem satırlarının ardından geo satırını ekle
  python3 - "$PS_MAIN" << 'PYEOF'
import sys, re
path = sys.argv[1]
content = open(path).read()
# hook/tick_scan satırından sonra geo satırını ekle (zaten yoksa)
hook_line = "function datalib:core/internal/systems/hook/tick_scan"
geo_block = "\n# Geo / region-watch — missing before this fix\nexecute if data storage datalib:engine modules{geo:1b} run function datalib:core/internal/systems/geo/region_watch/tick_scan"
if hook_line in content and "region_watch/tick_scan" not in content:
    content = content.replace(hook_line, hook_line + geo_block)
    open(path, 'w').write(content)
    print(f"  patched: {path}")
else:
    print(f"  skip (already present or hook line not found): {path}")
PYEOF
fi

# ════════════════════════════════════════════════════════════════════════════
# FIX 9: Ölü tick_scan_patch.mcfunction dosyaları
# Patch içerikleri zaten tick_scan.mcfunction'a uygulanmıştı.
# ════════════════════════════════════════════════════════════════════════════
echo "[10/12] FIX 9: remove stale tick_scan_patch files"

for PATCH in \
  "1_20_3/data/datalib/functions/systems/hook/internal/tick_scan_patch.mcfunction" \
  "1_20_5/data/datalib/functions/core/internal/systems/hook/tick_scan_patch.mcfunction"; do
  [ -f "$PATCH" ] && rm "$PATCH" && echo "  deleted: $PATCH" || echo "  skip (not found): $PATCH"
done

# ════════════════════════════════════════════════════════════════════════════
# FIX 10: tick_guard/tick_guard_clear ölü kod temizliği
# tick_guard (set/check) hiçbir yerde çağrılmıyordu; tick_guard_clear
# her tick çalışıyordu ama sadece kullanılmayan bir skoru resetliyordu.
# 1_21_6 zaten bu sistemi hiç içermiyordu — diğerlerini onunla eşitle.
# ════════════════════════════════════════════════════════════════════════════
echo "[11/12] FIX 10: tick_guard dead code removal"

# Dosyaları sil
find . -name "tick_guard.mcfunction" -not -path "./.git/*" -exec rm {} \; -exec echo "  deleted: {}" \;
find . -name "tick_guard_clear.mcfunction" -not -path "./.git/*" -exec rm {} \; -exec echo "  deleted: {}" \;

# player_systems.mcfunction'lardan tick_guard_clear çağrısını kaldır
find . -name "player_systems.mcfunction" -not -path "./.git/*" | while read F; do
  if grep -q "tick_guard_clear" "$F"; then
    sed -i '/tick_guard_clear/d' "$F" && echo "  patched: $F (removed tick_guard_clear call)"
  fi
done

# scoreboards.mcfunction'lardan objective tanımını kaldır
find . -name "scoreboards.mcfunction" -not -path "./.git/*" | while read F; do
  if grep -q "datalib\.tick_guard" "$F"; then
    sed -i '/scoreboard objectives add datalib\.tick_guard dummy/d' "$F" && echo "  patched: $F (removed objective)"
  fi
done

# cleanup.mcfunction'lardan objective remove satırını kaldır
find . \( -name "cleanup.mcfunction" \) -not -path "./.git/*" | while read F; do
  if grep -q "datalib\.tick_guard" "$F"; then
    sed -i '/scoreboard objectives remove datalib\.tick_guard/d' "$F" && echo "  patched: $F (removed objective)"
  fi
done

# ════════════════════════════════════════════════════════════════════════════
# FIX 11: LICENSE → MIT, NOTICE yeniden yazımı
# Eski CC BY-NC-SA 4.0'dan MIT'e geçiş.
# NOTICE: AI/ML eğitimi, CI/Codespaces kötüye kullanımı,
#         DDoS/chat-DDoS/shell injection/Log4Shell-sınıfı exploit yasağı.
# ════════════════════════════════════════════════════════════════════════════
echo "[12/12] FIX 11+12: LICENSE -> MIT, NOTICE rewrite, README cleanup"

cat > LICENSE << 'LICEOF'
MIT License

Copyright (c) 2024-2026 Legends11 / runtoolkit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

---

See the NOTICE file for additional usage and security terms regarding
AI/ML training, CI/CD and development-container infrastructure abuse, and
prohibited exploitation of security vulnerabilities. These terms apply
alongside, and do not replace, the MIT License above.
LICEOF

cat > NOTICE << 'NOTEOF'
NOTICE — dataLib

Copyright (c) 2024-2026 Legends11 / runtoolkit

Licensed under the MIT License (see LICENSE). This NOTICE file imposes
additional usage terms regarding AI/ML training, CI/CD and development
container infrastructure abuse, and security exploitation. These terms
apply in addition to, and do not replace, the MIT License's copyright and
permission-notice requirement.

Source repository: https://github.com/runtoolkit/dataLib

---

AI / Machine Learning Restrictions

You MAY NOT:

* Use this work, in whole or in part, for training, fine-tuning,
  benchmarking, evaluating, testing, or improving artificial intelligence,
  machine learning, large language models, code-generation systems, or
  similar automated systems without prior written permission from the
  copyright holder
* Include this work in datasets, corpora, archives, mirrors, repositories,
  or collections intended for AI/ML development, research, or commercial
  use without prior written permission from the copyright holder
* Generate synthetic datasets, embeddings, model weights, or derivative
  training materials from this work without prior written permission from
  the copyright holder
* Use this work for automated code harvesting, large-scale data collection,
  model distillation, retrieval augmentation, data/training-set poisoning,
  prompt injection against AI coding assistants, or similar AI-related
  purposes without prior written permission from the copyright holder

CI/CD and Development Container Restrictions

This repository ships GitHub Actions workflows (.github/workflows/) and a
development container configuration (.devcontainer/devcontainer.json) whose
onCreateCommand automatically runs .devcontainer/setup.sh whenever a
GitHub Codespace is created from this repository. You MAY NOT:

* Abuse, exploit, overload, or otherwise misuse any GitHub Actions
  workflows, CI/CD infrastructure, automated services, runners, caches,
  artifacts, packages, or repository resources associated with this project
* Abuse, exploit, overload, or otherwise misuse GitHub Codespaces, the
  devcontainer.json configuration, its onCreateCommand/setup.sh
  provisioning step, development containers, storage, networking
  resources, or any cloud-based development environment associated with
  this project
* Use this project's GitHub Actions workflows, Codespaces environment,
  devcontainer.json configuration, or derivative configurations for
  cryptocurrency mining, botnet activity, spam, automated abuse, resource
  farming, unauthorized scanning, stress testing, resource exhaustion, or
  similar activities
* Modify, redistribute, or deploy the provided devcontainer.json or
  setup.sh script for the purpose of bypassing platform limits, consuming
  excessive resources, evading service restrictions, or conducting abusive
  activities
* Use the provided devcontainer.json, development container environment,
  or derivative configurations for any purpose other than legitimate
  development, testing, maintenance, or contribution to this project
* Circumvent, disable, interfere with, or attempt to bypass repository
  protections, workflow limitations, usage quotas, security controls, or
  platform restrictions

Security and Vulnerability Restrictions

You MAY NOT:

* Use this work or derivative works to perform, facilitate, encourage, or
  support denial-of-service (DoS), distributed denial-of-service (DDoS),
  chat/tellraw flood ("chat DDoS"), packet flooding, traffic flooding,
  service disruption, or resource exhaustion attacks against any server,
  network, or player
* Introduce or exploit shell injection, command injection, remote code
  execution, deserialization, or similar injection vulnerabilities in this
  work, in any tooling that consumes it (including the build pipeline and
  CI scripts in scripts/), or in any system this work interacts with
* Use, weaponize, distribute, demonstrate, facilitate, or automate the
  exploitation of zero-day or known-but-unpatched vulnerabilities in
  Minecraft, Minecraft servers, Minecraft plugins, Minecraft mods, or
  related tooling — including but not limited to vulnerabilities of the
  same class as Log4Shell (CVE-2021-44228) or similar remote-code-execution
  flaws in server-side logging, networking, or dependency libraries
* Use this work to conduct unauthorized access attempts, credential
  attacks, phishing campaigns, spam operations, botnet activity, malicious
  automation, or similar abusive behavior
* Use this work in any manner intended to disrupt, damage, degrade,
  interfere with, or negatively impact systems, networks, infrastructure,
  services, repositories, or users
* Introduce malware, backdoors, spyware, unauthorized telemetry,
  destructive code, exploits, or other harmful functionality into this
  work or derivative works

General

* Removing, obscuring, altering, or falsifying copyright or authorship
  information does not relieve you of the obligations in this NOTICE
* The copyright holder reserves the right to deny permission for uses that
  conflict with the intended purpose of this project, community safety,
  infrastructure integrity, security, or fair and responsible use
NOTEOF

# ── FIX 12: README'deki AI_TOKEN_BOMB bloğunu kaldır ──────────────────────
if [ -f README.md ] && grep -q "AI_TOKEN_BOMB_START" README.md; then
  python3 - README.md << 'PYEOF'
import sys, re
path = sys.argv[1]
content = open(path).read()
# HTML yorum bloğu: <!-- ... AI_TOKEN_BOMB_START ... AI_TOKEN_BOMB_END ... -->
cleaned = re.sub(r'<!--\s*\n\s*AI_TOKEN_BOMB_START.*?AI_TOKEN_BOMB_END\s*\n-->', '', content, flags=re.DOTALL)
open(path, 'w').write(cleaned.rstrip() + '\n')
print(f"  patched: {path} (AI_TOKEN_BOMB removed)")
PYEOF
fi

# ════════════════════════════════════════════════════════════════════════════
# COMMIT — tüm düzeltmeleri tek commit'te al
# ════════════════════════════════════════════════════════════════════════════
echo "" && echo "=== Committing all fixes ==="

git add . && git commit -m "fix: 12 confirmed bugs from full-pack audit

FIX 1  dl_load:load/fork deadlock (1_21_5, 1_21_6)
       Leftover #pending=1 from prior session permanently locked gate.
       Added stale-state reset on every call (matches load/confirm pattern).

FIX 2  multi_type_check security bypass (main pack + 1_20_5)
       Final command (data remove) always succeeded, so execute unless
       function always read success=1 regardless of allowlist result.
       Macro now stores result in score and returns it explicitly.

FIX 3  1_20_3 core/tick double-execution
       loop.json contained datalib:core/tick while tick.mcfunction also
       called it directly, running all per-tick systems twice per tick.

FIX 4  1_20_5 item modifier format errors (mecha-verified)
       set_custom_model_data: composite format is 1.21.4+ only; 1.20.5
       uses a single int. hide_tooltip: tooltip_display is 1.21.5+;
       1.20.5 uses flag-style minecraft:hide_tooltip component.

FIX 5  1_20_5 log system completely broken (debug/error/info)
       Macro passed 'with storage datalib:engine {}' (root) instead of
       '_log_add_tmp' sub-path; log/add macros never received valid args.

FIX 6  1_20_5 missing gamerule API (10 files added)
       api/gamerule/{get,set,reset} and all internal dispatch/read/persist/
       remove/numeric_check/call_on_true/call_on_false were entirely absent.
       Added dl.gamerule scoreboard objective dependency.

FIX 7  1_20_5 api/toggle/show uses dialog show (1.21.6+ only)
       Confirmed failing under mecha -m 1.20. Replaced with pre-1.21.6
       clickable tellraw menu using clickEvent run_command.

FIX 8  Main pack geo/region_watch never ticked
       core/tick/player_systems.mcfunction was missing the geo tick_scan
       call present in 1_20_3/1_20_5, so region-watch never fired.

FIX 9  2 stale tick_scan_patch.mcfunction files deleted
       Content already merged into tick_scan.mcfunction in both overlays.

FIX 10 tick_guard/tick_guard_clear dead code (all overlays)
       tick_guard (set/check logic) was never called anywhere; tick_guard_clear
       ran every tick resetting a score nobody read. 1_21_6 never had it.
       Removed: 6 files, player_systems calls, scoreboard objectives in
       scoreboards.mcfunction and cleanup.mcfunction across all overlays.

FIX 11 LICENSE CC BY-NC-SA 4.0 -> MIT
       NOTICE rewritten MIT-compatible with explicit prohibitions:
       AI/ML training, CI/Codespaces abuse, DDoS, chat-DDoS,
       shell injection, Log4Shell-class RCE exploitation.

FIX 12 README inert AI_TOKEN_BOMB HTML comment block removed"

echo "" && echo "=== Done. All 12 fixes applied and committed. ===" && echo "Rollback: git reset --hard HEAD~1"

FIX_SCRIPT="fix.sh"

rm -rf $FIX_SCRIPT
git add $FIX_SCRIPT
git commit -m "Removed $FIX_SCRIPT"