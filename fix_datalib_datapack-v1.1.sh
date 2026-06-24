#!/usr/bin/env bash
set -Eeuo pipefail
shopt -s nullglob

export HISTFILE=/dev/null

SCRIPT_NAME="fix-datalib-datapack.sh"
ROOT=""
BRANCH=""
BACKUP_DIR=""
PATCHED_COUNT=0
VALIDATED_COUNT=0
ERROR_COUNT=0

cleanup() {
  printf '\e[?25h' >/dev/tty 2>/dev/null || true
  stty sane 2>/dev/null || true
}
trap cleanup EXIT INT TERM

log() { printf '%s\n' "$*"; }
step() { printf '%s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*" >&2; }
fail() { printf 'ERROR: %s\n' "$*" >&2; ((ERROR_COUNT++)); }

find_repo_root() {
  local candidates=(
    "${CODESPACES:-}"
    "/workspace/dataLib"
    "/workspaces/dataLib"
  )
  if [[ -f "./pack.mcmeta" && -d "./data" ]]; then
    printf '%s\n' "$PWD"
    return 0
  fi

  local d="$PWD"
  while [[ "$d" != "/" ]]; do
    if [[ -f "$d/pack.mcmeta" && -d "$d/data" ]]; then
      printf '%s\n' "$d"
      return 0
    fi
    d="$(dirname "$d")"
  done

  for c in "/workspace/dataLib" "/workspaces/dataLib"; do
    if [[ -f "$c/pack.mcmeta" && -d "$c/data" ]]; then
      printf '%s\n' "$c"
      return 0
    fi
  done

  return 1
}

prompt_root() {
  local input=""
  printf 'Repo yolu gir: '
  IFS= read -r input
  if [[ -z "$input" ]]; then
    return 1
  fi
  if [[ ! -f "$input/pack.mcmeta" || ! -d "$input/data" ]]; then
    fail "Geçerli datapack kökü bulunamadı: $input"
    return 1
  fi
  printf '%s\n' "$input"
}

resolve_branch() {
  local repo="$1"
  if command -v git >/dev/null 2>&1 && git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local b
    b="$(git -C "$repo" rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
    if [[ -n "$b" && "$b" != "HEAD" ]]; then
      printf '%s\n' "$b"
      return 0
    fi
  fi

  local input=""
  printf 'Branch adı gir: '
  IFS= read -r input
  printf '%s\n' "${input:-unknown}"
}

is_codespaces_path() {
  [[ -n "${CODESPACES:-}" || -n "${GITHUB_CODESPACES_NAME:-}" ]] && return 0
  [[ "$PWD" == /workspace/dataLib* || "$PWD" == /workspaces/dataLib* ]]
}

ensure_backup() {
  local repo="$1"
  BACKUP_DIR="$repo/.fixDatapack-backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
}

backup_file() {
  local repo="$1"
  local file="$2"
  local rel="${file#"$repo"/}"
  local dest="$BACKUP_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  cp -p "$file" "$dest"
}

classify_risk() {
  local file="$1"
  local path_lc="${file,,}"
  local risk=1

  if [[ "$path_lc" == *"/api/cmd/"* || "$path_lc" == *"/functions/api/cmd/"* ]]; then
    risk=3
  fi
  if [[ "$path_lc" == *"/api/security/"* || "$path_lc" == *"/api/perm/"* || "$path_lc" == *"/api/toggle/"* || "$path_lc" == *"/debug/tools/admin/"* ]]; then
    (( risk < 3 )) && risk=3
  fi
  if [[ "$path_lc" == *"/core/security/"* || "$path_lc" == *"input_check.mcfunction" || "$path_lc" == *"cmd_gate.mcfunction" ]]; then
    risk=4
  fi

  if grep -Eq '(\$\(|\bkill\b|\bdeop\b|\bop\b|\bban(_ip)?\b|\bwhitelist\b|\bgamemode\b|\btp\b|\bsummon\b|\bdata modify storage datalib:engine\b|\bscoreboard players set\b.*dl\.perm_level)' "$file"; then
    (( risk < 4 )) && risk=4
  fi

  if grep -Eq '\bexecute .* with storage\b|\bfunction .* with storage\b' "$file"; then
    (( risk < 3 )) && risk=3
  fi

  printf '%s\n' "$risk"
}

has_line() {
  local file="$1"
  local needle="$2"
  grep -Fq "$needle" "$file"
}

insert_guard_block() {
  local file="$1"
  local risk="$2"
  local tmp
  tmp="$(mktemp)"

  python3 - "$file" "$risk" <<'PY'
import sys, pathlib, re

path = pathlib.Path(sys.argv[1])
risk = int(sys.argv[2])

text = path.read_text(encoding='utf-8', errors='replace')
lines = text.splitlines()

# Decide if we should add guards.
lower = str(path).lower()
needs_cmd_gate = ('/api/' in lower or '/functions/api/' in lower) and 'cmd_gate' not in text
needs_input_check = (
    ('/api/' in lower or '/functions/api/' in lower or '$( ' in text or '$(' in text)
    and 'input_check' not in text
)
needs_admin = risk >= 4 and 'datalib.admin' not in text
required_perm = {1: 1, 3: 3, 4: 4}[risk]

# Replace any existing dl.perm_level thresholds in execute guards.
text2 = re.sub(
    r'(scores=\{[^}]*dl\.perm_level=)\d+\.\.(\})',
    rf'\g<1>{required_perm}..\2',
    text
)

# Recompute lines after threshold replacement.
lines = text2.splitlines()

guard = []
guard.append('# --- fixDatapack injected security guard ---')
if needs_input_check:
    guard.append('execute unless function datalib:debug/tools/utils/input_check run return 0')
if needs_cmd_gate:
    guard.append('execute unless function datalib:core/security/cmd_gate run return 0')
guard.append(f'execute unless entity @s[scores={{dl.perm_level={required_perm}..}}] run return 0')
if needs_admin:
    guard.append('execute unless entity @s[tag=datalib.admin] run return 0')
guard.append('# --- end fixDatapack injected security guard ---')

# If there is already a guard block, do not add a second one.
if 'fixDatapack injected security guard' not in text2:
    idx = 0
    while idx < len(lines) and (lines[idx].strip() == '' or lines[idx].lstrip().startswith('#')):
        idx += 1
    new_lines = lines[:idx] + guard + lines[idx:]
else:
    new_lines = lines

new_text = '\n'.join(new_lines) + ('\n' if text.endswith('\n') else '')
path.write_text(new_text, encoding='utf-8')
PY
}

validate_json_file() {
  local file="$1"
  python3 - "$file" <<'PY'
import json, sys, pathlib
p = pathlib.Path(sys.argv[1])
try:
    json.loads(p.read_text(encoding='utf-8'))
except Exception as e:
    print(f"JSON error in {p}: {e}", file=sys.stderr)
    sys.exit(1)
PY
}

validate_functions() {
  local repo="$1"
  python3 - "$repo" <<'PY'
import pathlib, re, sys, json
repo = pathlib.Path(sys.argv[1])
files = [p for p in repo.rglob('*.mcfunction') if '.fixDatapack-backup-' not in str(p)]
existing = set()
for p in files:
    rel = p.relative_to(repo).as_posix()
    existing.add(rel)

# Support function ids from both old/new layouts by normalizing paths to ids.
def to_id(rel: str):
    parts = rel.split('/')
    if len(parts) < 4:
        return None
    if parts[0] in {'data', '1_20_3', '1_20_5', '1_21_5', '1_21_6', '26_1', '26_2', '_pre_1_21_4', 'compat_1_21_4'}:
        try:
            i = parts.index('data')
        except ValueError:
            return None
        if len(parts) <= i + 3:
            return None
        ns = parts[i + 1]
        if parts[i + 2] not in {'function', 'functions'}:
            return None
        fn = '/'.join(parts[i + 3:]).removesuffix('.mcfunction')
        return f'{ns}:{fn}'
    return None

ids = {}
for p in files:
    fid = to_id(p.relative_to(repo).as_posix())
    if fid:
        ids[fid] = p

missing = []
for p in files:
    text = p.read_text(encoding='utf-8', errors='replace')
    for m in re.finditer(r'(?<!\$)function\s+([a-z0-9_.\-]+:[A-Za-z0-9_./\-]+)', text):
        target = m.group(1)
        if '$(' in target:
            continue
        # Ignore macro-driven references
        if target not in ids:
            missing.append((p.relative_to(repo).as_posix(), target))
            if len(missing) >= 20:
                break
    if len(missing) >= 20:
        break

if missing:
    for src, target in missing:
        print(f"Missing function reference: {src} -> {target}", file=sys.stderr)
    sys.exit(1)
PY
}

main() {
  printf 'Starting...\n'
  printf ':start.detect\n'

  if is_codespaces_path; then
    if [[ -d /workspace/dataLib && -f /workspace/dataLib/pack.mcmeta ]]; then
      ROOT="/workspace/dataLib"
    elif [[ -d /workspaces/dataLib && -f /workspaces/dataLib/pack.mcmeta ]]; then
      ROOT="/workspaces/dataLib"
    else
      ROOT="$(find_repo_root || true)"
    fi
  else
    ROOT="$(find_repo_root || true)"
    if [[ -z "$ROOT" ]]; then
      ROOT="$(prompt_root || true)"
    fi
  fi

  if [[ -z "$ROOT" ]]; then
    fail "Datapack kökü bulunamadı."
    printf ':done.doneScript\n'
    exit 1
  fi

  BRANCH="$(resolve_branch "$ROOT")"
  printf 'Root: %s\n' "$ROOT"
  printf 'Branch: %s\n' "$BRANCH"

  ensure_backup "$ROOT"

  local files
  mapfile -d '' files < <(
    find "$ROOT" \
      \( -path "$ROOT/.git" -o -path "$ROOT/.fixDatapack-backup-*" \) -prune -o \
      -name '*.mcfunction' -print0
  )

  if [[ "${#files[@]}" -eq 0 ]]; then
    fail "Hiç .mcfunction dosyası bulunamadı."
    printf ':done.doneScript\n'
    exit 1
  fi

  printf ':fixDatapack\n'
  for file in "${files[@]}"; do
    [[ -f "$file" ]] || continue
    backup_file "$ROOT" "$file"

    risk="$(classify_risk "$file")"

    # Always keep the file structure intact: only in-place edits, no overlay merging.
    # Add guards only to public-facing API paths or files with dynamic command payloads.
    if grep -Eq '(\$\(|function\s+[a-z0-9_.\-]+:[A-Za-z0-9_./\-]+\s+with\s+storage)' "$file" || [[ "${file,,}" == *"/api/"* || "${file,,}" == *"/functions/api/"* ]]; then
      python3 - "$file" "$risk" <<'PY'
import sys, pathlib, re
path = pathlib.Path(sys.argv[1])
risk = int(sys.argv[2])

text = path.read_text(encoding='utf-8', errors='replace')
lines = text.splitlines()

lower = str(path).lower()
needs_cmd_gate = ('/api/' in lower or '/functions/api/' in lower) and 'cmd_gate' not in text
needs_input_check = ('/api/' in lower or '/functions/api/' in lower or '$(' in text) and 'input_check' not in text
needs_admin = risk >= 4 and 'datalib.admin' not in text
required_perm = {1: 1, 3: 3, 4: 4}[risk]

text2 = re.sub(
    r'(scores=\{[^}]*dl\.perm_level=)\d+\.\.(\})',
    rf'\g<1>{required_perm}..\2',
    text
)

# Avoid duplicate guard blocks.
if 'fixDatapack injected security guard' not in text2:
    lines = text2.splitlines()
    guard = ['# --- fixDatapack injected security guard ---']
    if needs_input_check:
        guard.append('execute unless function datalib:debug/tools/utils/input_check run return 0')
    if needs_cmd_gate:
        guard.append('execute unless function datalib:core/security/cmd_gate run return 0')
    guard.append(f'execute unless entity @s[scores={{dl.perm_level={required_perm}..}}] run return 0')
    if needs_admin:
        guard.append('execute unless entity @s[tag=datalib.admin] run return 0')
    guard.append('# --- end fixDatapack injected security guard ---')

    idx = 0
    while idx < len(lines) and (lines[idx].strip() == '' or lines[idx].lstrip().startswith('#')):
        idx += 1
    lines = lines[:idx] + guard + lines[idx:]
    text2 = '\n'.join(lines) + ('\n' if text.endswith('\n') else '')

path.write_text(text2, encoding='utf-8')
PY
      ((PATCHED_COUNT++))
    fi
  done

  printf ':validateFixes\n'

  # Validate root metadata and function tag JSON.
  if [[ -f "$ROOT/pack.mcmeta" ]]; then
    validate_json_file "$ROOT/pack.mcmeta"
  else
    fail "pack.mcmeta yok."
  fi

  while IFS= read -r -d '' jsonf; do
    validate_json_file "$jsonf"
  done < <(find "$ROOT/data/minecraft/tags/function" -name '*.json' -print0 2>/dev/null || true)

  validate_functions "$ROOT"
  ((VALIDATED_COUNT++))

  printf ':done\n'
  printf ':dome.doneScript\n'
  printf 'Success: %s\n' "$ROOT"
  printf 'Patched files: %s\n' "$PATCHED_COUNT"
  printf 'Validated steps: %s\n' "$VALIDATED_COUNT"

  printf ':done.doneScript\n'
  exit 0
}

main "$@"
