# 🔧 dataLib
**Minecraft Java Edition 26.2 | Multiplayer-Safe | Pure Datapack**

[![CI](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml/badge.svg)](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Download on Modrinth](https://img.shields.io/badge/Download%20on-Modrinth-00AF5C?style=for-the-badge&logo=modrinth&logoColor=white)](https://modrinth.com/datapack/datalib)

---
> Current version: **v6.0.1-pre1**
---

> [!WARNING]
> **This datapack is considered safe to use, but it is still actively receiving security improvements, bug fixes, and new features. Please keep it up to date.**
>
> **Do not copy `datalib:input` or `datalib:engine` into your own datapack.** It is an internal implementation detail and may change without notice between releases.

---

> [!NOTE]
> /reload is no longer required. dataLib initializes automatically, and player-targeted commands (such as tellraw @s) are executed when the first player joins the world.
---
> 🛡️ **This is a Minecraft Datapack — it contains no executables or scripts outside of `.mcfunction` files.**
> Some antivirus software may flag `.mcfunction` files as suspicious due to macro-like syntax. This is a **false positive**. The pack has been scanned on [VirusTotal](https://www.virustotal.com) and returned clean.
> **Only download from this official repository.** Do not trust redistributed or repackaged versions from third-party sources.

---

## 📦 Installation

1. Place dataLib-full.zip into <world>/datapacks/

2. Add the following logic to your datapack's initialization files:

```mcfunction
#> <namespace>:load
execute unless data storage datalib:engine {global:{loaded:1b}} run function <namespace>:load_datalib
```

```mcfunction
#> <namespace>:load_datalib

execute if data storage <namespace>:engine {loaded_datalib:1b} run return 0

function dl_load:load/yes
function dl_load:load/fork_no

data modify storage <namespace>:engine loaded_datalib set value 1b
```

---

## 🏗️ Storage Architecture

```
datalib:engine  (persistent data)
├── global
│   ├── version: "v6.0.1-pre1"
│   └── tick: <int>
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b, ... }
├── queue
│   └── [{func:"mypack:event/end", delay:100}]
├── cooldowns
│   └── Steve { fireball: 2460, dash: 1870 }  ← expiry ticks
└── events
    └── on_join: [{func:"mypack:welcome"}, {func:"mypack:xp_bonus"}]

datalib:input   (sending data to a function)
datalib:output  (receiving results from a function)
```

---

## 🔍 Predicate Reference

Used with `execute if predicate <id>`.

| Predicate | Description |
|---|---|
| `datalib:is_survival` | Player is in survival mode |
| `datalib:is_creative` | Player is in creative mode |
| `datalib:has_empty_mainhand` | Main hand is empty |
| `datalib:is_full_health` | Player is at full health (20 HP) |
| `datalib:is_sneaking` | Player is sneaking |
| `datalib:is_sprinting` | Player is sprinting |
| `datalib:is_burning` | Player is on fire |
| `datalib:is_on_ground` | Player is on the ground |
| `datalib:is_daytime` | Daytime (0–12000 ticks) |
| `datalib:is_raining` | It is raining |
| `datalib:is_thundering` | There is a thunderstorm |
| `datalib:in_overworld` | Player is in the Overworld |
| `datalib:in_nether` | Player is in the Nether |
| `datalib:in_end` | Player is in the End |

Full reference: [Predicate Reference](https://github.com/runtoolkit/dataLib-dp/wiki)

---

## 📦 Dependencies

### Lantern Load
**Repository:** https://github.com/LanternMC/load  
**License:** BSD 0-Clause (public domain)

Provides deterministic load order, version tracking, and pre/load/post-load hooks.

```mcfunction
# Check if dataLib is loaded
execute if score #dataLib load.status matches 1.. run say dataLib is loaded

# Get version (major*10000 + minor*100 + patch → v6.0.1 = 601)
scoreboard players get dataLib load.status
```

### StringLib
**Repository:** https://github.com/CMDred/StringLib  
**License:** MIT

Bundled under the `stringlib` namespace. Exposed via `datalib:core/lib/string/*`.

| Function | Description |
|---|---|
| `lib/string/concat` | Join a string array |
| `lib/string/find` | Find substring index |
| `lib/string/replace` | Replace substring |
| `lib/string/split` | Split by separator |
| `lib/string/insert` | Insert at index |
| `lib/string/to_lowercase` | Lowercase (A–Z, fast) |
| `lib/string/to_uppercase` | Uppercase (a–z, fast) |
| `lib/string/to_number` | String → numeric NBT |
| `lib/string/to_string` | Value → string |

All functions read from `datalib:input` and write to `datalib:output string.result`.

```mcfunction
data modify storage datalib:input string set value "Hello World"
data modify storage datalib:input find set value "World"
data modify storage datalib:input replace set value "Everyone"
function datalib:core/lib/string/replace
# datalib:output string.result → "Hello Everyone"
```


## 💉 Injecting into Another Datapack

These methods **do not merge dataLib into your source datapack.** Your original datapack folder is left untouched. Each method reads a target datapack path, copies `datalib` in alongside it, patches a generated hook into `<namespace>:load`, and writes the result as a **new, separate zip** next to your original — producing two outputs:

- `dataLib-full.zip` — dataLib alone, unchanged (from `./gradlew zipFull`)
- `<target>-injected.zip` — your datapack + dataLib + the load hook, packaged together

None of the four methods below write to your source files. They only read from `datapacks/dataLib` (or `dataLib-full.zip`) and the target path you give them, and write to an output directory.

---

### Method 1 — GitHub Actions

Add this as a **reusable workflow** (`.github/workflows/inject.yml`) in your *own* datapack repo, or call it via `workflow_call` from `runtoolkit/dataLib-dp`. It checks out both repos, copies `datalib` into a scratch copy of your pack, patches the hook, and uploads the result as a build artifact — your repo's tracked files are never modified or committed back.

```yaml
name: Inject dataLib

on:
  workflow_dispatch:
    inputs:
      target_namespace:
        description: "Your datapack's namespace (e.g. mypack)"
        required: true
      datalib_ref:
        description: "dataLib-dp ref/tag to inject"
        default: "main"

jobs:
  inject:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout target datapack
        uses: actions/checkout@v6
        with:
          path: target

      - name: Checkout dataLib-dp
        uses: actions/checkout@v6
        with:
          repository: runtoolkit/dataLib-dp
          ref: ${{ inputs.datalib_ref }}
          path: datalib-src

      - name: Build dataLib-full.zip
        working-directory: datalib-src
        run: |
          chmod +x gradlew
          ./gradlew zipFull --no-daemon

      - name: Assemble injected copy (scratch dir, source untouched)
        env:
          NS: ${{ inputs.target_namespace }}
        run: |
          set -euo pipefail
          mkdir -p out/injected
          cp -r target/. out/injected/
          mkdir -p tmp_datalib
          unzip -q datalib-src/build/dist/dataLib-full.zip -d tmp_datalib
          cp -r tmp_datalib/data/datalib out/injected/data/
          cp -r tmp_datalib/data/dl_load out/injected/data/
          cp -r tmp_datalib/data/stringlib out/injected/data/
          cp -r tmp_datalib/data/datalib.main out/injected/data/
          cp -r tmp_datalib/data/stringlib out/injected/data/

          LOAD_FILE="out/injected/data/${NS}/function/load.mcfunction"
          mkdir -p "$(dirname "$LOAD_FILE")"
          if ! grep -q "loaded_datalib" "$LOAD_FILE" 2>/dev/null; then
            cat <<EOF >> "$LOAD_FILE"

          execute unless data storage datalib:engine {global:{loaded:1b}} run function ${NS}:load_datalib
          EOF
          fi

          cat <<EOF > "out/injected/data/${NS}/function/load_datalib.mcfunction"
          execute if data storage ${NS}:engine {loaded_datalib:1b} run return 0

          function dl_load:load/yes
          function dl_load:load/fork_no

          data modify storage ${NS}:engine loaded_datalib set value 1b
          EOF

      - name: Zip injected pack
        run: cd out/injected && zip -qr ../../${{ inputs.target_namespace }}-injected.zip .

      - uses: actions/upload-artifact@v7
        with:
          name: dataLib-full
          path: datalib-src/build/dist/dataLib-full.zip
          if-no-files-found: error

      - uses: actions/upload-artifact@v7
        with:
          name: ${{ inputs.target_namespace }}-injected
          path: ${{ inputs.target_namespace }}-injected.zip
          if-no-files-found: error
```

Two artifacts are produced per run: the plain `dataLib-full.zip` and `<namespace>-injected.zip`. Neither is committed to any repo.

---

### Method 2 — Bash

```bash
#!/usr/bin/env bash
# inject-datalib.sh
# Usage: ./inject-datalib.sh <path-to-target-datapack> <target-namespace> [dataLib-full.zip]
set -euo pipefail

TARGET_DIR="${1:?target datapack path required}"
NAMESPACE="${2:?target namespace required}"
DATALIB_ZIP="${3:-dataLib-full.zip}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "error: target datapack not found: $TARGET_DIR" >&2
  exit 1
fi

# If dataLib-full.zip is missing, clone dataLib-dp and build it.
if [ ! -f "$DATALIB_ZIP" ]; then
  echo "warning: $DATALIB_ZIP not found. Cloning and building dataLib-dp..." >&2
  BUILD_DIR="$(mktemp -d)"
  git clone https://github.com/runtoolkit/dataLib-dp.git "$BUILD_DIR/dataLib-dp"
  (
    cd "$BUILD_DIR/dataLib-dp"
    chmod +x ./gradlew
    ./gradlew zipFull
  )
  # Locate the produced zip (adjust glob if the actual output path differs).
  BUILT_ZIP="$(find "$BUILD_DIR/dataLib-dp" -maxdepth 6 -iname 'dataLib-full*.zip' -print -quit)"
  if [ -z "$BUILT_ZIP" ]; then
    echo "error: zipFull ran but no dataLib-full*.zip was found under build output." >&2
    rm -rf "$BUILD_DIR"
    exit 1
  fi
  cp "$BUILT_ZIP" "$DATALIB_ZIP"
  rm -rf "$BUILD_DIR"
fi

OUT_DIR="$(mktemp -d)"
trap 'rm -rf "$OUT_DIR"' EXIT

# Copy target into scratch — source datapack is never touched.
cp -r "$TARGET_DIR/." "$OUT_DIR/"

# Unpack dataLib and copy only its known data folders in.
UNZIP_DIR="$(mktemp -d)"
unzip -q "$DATALIB_ZIP" -d "$UNZIP_DIR"
mkdir -p "$OUT_DIR/data"

for module in datalib datalib.main dl_load player_action stringlib; do
  SRC="$UNZIP_DIR/data/$module"
  if [ ! -d "$SRC" ]; then
    echo "error: expected module missing from zip: data/$module" >&2
    rm -rf "$UNZIP_DIR"
    exit 1
  fi
  cp -r "$SRC" "$OUT_DIR/data/"
done
rm -rf "$UNZIP_DIR"

# Patch the load hook.
LOAD_FILE="$OUT_DIR/data/$NAMESPACE/function/load.mcfunction"
mkdir -p "$(dirname "$LOAD_FILE")"
touch "$LOAD_FILE"
if ! grep -q "loaded_datalib" "$LOAD_FILE"; then
  {
    echo ""
    echo "execute unless data storage datalib:engine {global:{loaded:1b}} run function ${NAMESPACE}:load_datalib"
  } >> "$LOAD_FILE"
fi

cat > "$OUT_DIR/data/$NAMESPACE/function/load_datalib.mcfunction" <<EOF
execute if data storage ${NAMESPACE}:engine {loaded_datalib:1b} run return 0
function dl_load:load/yes
function dl_load:load/fork_no
data modify storage ${NAMESPACE}:engine loaded_datalib set value 1b
EOF

OUT_ZIP="$(basename "$TARGET_DIR")-injected.zip"
( cd "$OUT_DIR" && zip -qr "$OLDPWD/$OUT_ZIP" . )
echo "Wrote $OUT_ZIP ($TARGET_DIR was not modified)"
```

---

## 💬 Support

[![Issues](https://img.shields.io/github/issues/runtoolkit/dataLib-dp?style=for-the-badge)](https://github.com/runtoolkit/dataLib-dp/issues)
[![Discussions](https://img.shields.io/github/discussions/runtoolkit/dataLib-dp?style=for-the-badge&logo=github&color=blue)](https://github.com/runtoolkit/dataLib-dp/discussions)

---

*dataLib v6.0.1 | MC Java 26.2 | Pure Datapack*
