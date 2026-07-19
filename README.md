# 🔧 dataLib
**Minecraft Java Edition 26.2 | Multiplayer-Safe | Pure Datapack**

[![CI](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml/badge.svg)](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Download on Modrinth](https://img.shields.io/badge/Download%20on-Modrinth-00AF5C?style=for-the-badge&logo=modrinth&logoColor=white)](https://modrinth.com/datapack/datalib)

---
> Current version: **v6.0.1-pre2**
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
tag @s add datalib.admin
scoreboard players set @s[tag=datalib.admin,type=minecraft:player] dl.perm_level 4

data modify storage <namespace>:engine loaded_datalib set value 1b
```

---

## 🏗️ Storage Architecture

```
datalib:engine  (persistent data)
├── global
│   ├── version: "v6.0.1-pre2"
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
          tag @s add datalib.admin
          scoreboard players set @s[tag=datalib.admin,type=minecraft:player] dl.perm_level 4

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
if [ ! -f "$DATALIB_ZIP" ]; then
  echo "error: $DATALIB_ZIP not found. Run './gradlew zipFull' in dataLib-dp first." >&2
  exit 1
fi

OUT_DIR="$(mktemp -d)"
trap 'rm -rf "$OUT_DIR"' EXIT

# Copy target into scratch — source datapack is never touched.
cp -r "$TARGET_DIR/." "$OUT_DIR/"

# Unpack dataLib and copy only its data/datalib folder in.
UNZIP_DIR="$(mktemp -d)"
unzip -q "$DATALIB_ZIP" -d "$UNZIP_DIR"
mkdir -p "$OUT_DIR/data"
cp -r "$UNZIP_DIR/data/datalib" "$OUT_DIR/data/"
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
tag @s add datalib.admin
scoreboard players set @s[tag=datalib.admin,type=minecraft:player] dl.perm_level 4

data modify storage ${NAMESPACE}:engine loaded_datalib set value 1b
EOF

OUT_ZIP="$(basename "$TARGET_DIR")-injected.zip"
( cd "$OUT_DIR" && zip -qr "$OLDPWD/$OUT_ZIP" . )

echo "Wrote $OUT_ZIP ($TARGET_DIR was not modified)"
```

---

### Method 3 — Python

```python
#!/usr/bin/env python3
"""
inject_datalib.py
Usage: python3 inject_datalib.py <target_dir> <namespace> [datalib_zip]
"""
import shutil
import sys
import tempfile
import zipfile
from pathlib import Path

LOAD_HOOK = (
    "\nexecute unless data storage datalib:engine {{global:{{loaded:1b}}}} "
    "run function {ns}:load_datalib\n"
)

LOAD_DATALIB_FN = """\
execute if data storage {ns}:engine {{loaded_datalib:1b}} run return 0

function dl_load:load/yes
function dl_load:load/fork_no
tag @s add datalib.admin
scoreboard players set @s[tag=datalib.admin,type=minecraft:player] dl.perm_level 4

data modify storage {ns}:engine loaded_datalib set value 1b
"""


def inject(target_dir: str, namespace: str, datalib_zip: str = "dataLib-full.zip") -> Path:
    target = Path(target_dir)
    if not target.is_dir():
        raise SystemExit(f"error: target datapack not found: {target}")

    datalib_zip_path = Path(datalib_zip)
    if not datalib_zip_path.is_file():
        raise SystemExit(
            f"error: {datalib_zip_path} not found. "
            "Run './gradlew zipFull' in dataLib-dp first."
        )

    with tempfile.TemporaryDirectory() as scratch_str:
        scratch = Path(scratch_str)

        # Copy target into scratch — source datapack is never touched.
        injected = scratch / "injected"
        shutil.copytree(target, injected)

        # Unpack dataLib, copy only data/datalib in.
        unzip_dir = scratch / "datalib_unzipped"
        with zipfile.ZipFile(datalib_zip_path) as zf:
            zf.extractall(unzip_dir)
        dest_datalib = injected / "data" / "datalib"
        if dest_datalib.exists():
            shutil.rmtree(dest_datalib)
        shutil.copytree(unzip_dir / "data" / "datalib", dest_datalib)

        # Patch load hook.
        fn_dir = injected / "data" / namespace / "function"
        fn_dir.mkdir(parents=True, exist_ok=True)

        load_file = fn_dir / "load.mcfunction"
        existing = load_file.read_text() if load_file.exists() else ""
        if "loaded_datalib" not in existing:
            with load_file.open("a") as f:
                f.write(LOAD_HOOK.format(ns=namespace))

        (fn_dir / "load_datalib.mcfunction").write_text(
            LOAD_DATALIB_FN.format(ns=namespace)
        )

        # Zip result next to cwd, source untouched.
        out_zip = Path(f"{target.name}-injected.zip")
        if out_zip.exists():
            out_zip.unlink()
        base_name = str(out_zip.with_suffix(""))
        shutil.make_archive(base_name, "zip", injected)

        print(f"Wrote {out_zip} ({target} was not modified)")
        return out_zip


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    inject(sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else "dataLib-full.zip")
```

---

### Method 4 — JavaScript (Node.js)

Requires `adm-zip` (`npm install adm-zip`).

```javascript
#!/usr/bin/env node
// inject-datalib.js
// Usage: node inject-datalib.js <targetDir> <namespace> [dataLibZip]

const fs = require("fs");
const path = require("path");
const os = require("os");
const AdmZip = require("adm-zip");

function copyDirSync(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

function inject(targetDir, namespace, dataLibZip = "dataLib-full.zip") {
  if (!fs.existsSync(targetDir) || !fs.statSync(targetDir).isDirectory()) {
    throw new Error(`target datapack not found: ${targetDir}`);
  }
  if (!fs.existsSync(dataLibZip)) {
    throw new Error(
      `${dataLibZip} not found. Run './gradlew zipFull' in dataLib-dp first.`
    );
  }

  const scratch = fs.mkdtempSync(path.join(os.tmpdir(), "datalib-inject-"));
  const injectedDir = path.join(scratch, "injected");

  // Copy target into scratch — source datapack is never touched.
  copyDirSync(targetDir, injectedDir);

  // Unpack dataLib, copy only data/datalib in.
  const unzipDir = path.join(scratch, "datalib_unzipped");
  new AdmZip(dataLibZip).extractAllTo(unzipDir, true);
  const destDatalib = path.join(injectedDir, "data", "datalib");
  if (fs.existsSync(destDatalib)) fs.rmSync(destDatalib, { recursive: true });
  copyDirSync(path.join(unzipDir, "data", "datalib"), destDatalib);

  // Patch load hook.
  const fnDir = path.join(injectedDir, "data", namespace, "function");
  fs.mkdirSync(fnDir, { recursive: true });

  const loadFile = path.join(fnDir, "load.mcfunction");
  const existing = fs.existsSync(loadFile) ? fs.readFileSync(loadFile, "utf8") : "";
  if (!existing.includes("loaded_datalib")) {
    fs.appendFileSync(
      loadFile,
      `\nexecute unless data storage datalib:engine {global:{loaded:1b}} run function ${namespace}:load_datalib\n`
    );
  }

  fs.writeFileSync(
    path.join(fnDir, "load_datalib.mcfunction"),
    `execute if data storage ${namespace}:engine {loaded_datalib:1b} run return 0

function dl_load:load/yes
function dl_load:load/fork_no
tag @s add datalib.admin
scoreboard players set @s[tag=datalib.admin,type=minecraft:player] dl.perm_level 4

data modify storage ${namespace}:engine loaded_datalib set value 1b
`
  );

  // Zip result next to cwd, source untouched.
  const outZip = `${path.basename(targetDir)}-injected.zip`;
  const zip = new AdmZip();
  zip.addLocalFolder(injectedDir);
  zip.writeZip(outZip);

  fs.rmSync(scratch, { recursive: true });
  console.log(`Wrote ${outZip} (${targetDir} was not modified)`);
  return outZip;
}

const [, , targetDir, namespace, dataLibZip] = process.argv;
if (!targetDir || !namespace) {
  console.error("Usage: node inject-datalib.js <targetDir> <namespace> [dataLibZip]");
  process.exit(1);
}
inject(targetDir, namespace, dataLibZip);
```

---

## 💬 Support

[![Issues](https://img.shields.io/github/issues/runtoolkit/dataLib-dp?style=for-the-badge)](https://github.com/runtoolkit/dataLib-dp/issues)
[![Discussions](https://img.shields.io/github/discussions/runtoolkit/dataLib-dp?style=for-the-badge&logo=github&color=blue)](https://github.com/runtoolkit/dataLib-dp/discussions)

---

*dataLib v6.0.1 | MC Java 26.2 | Pure Datapack*
