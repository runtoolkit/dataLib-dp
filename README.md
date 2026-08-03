# 🔧 dataLib
**Minecraft Java Edition 26.2 | Multiplayer-Safe | Pure Datapack**

[![CI](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml/badge.svg)](https://github.com/runtoolkit/dataLib-dp/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Download on Modrinth](https://img.shields.io/badge/Download%20on-Modrinth-00AF5C?style=for-the-badge&logo=modrinth&logoColor=white)](https://modrinth.com/datapack/datalib)

---
> Current version: **v6.0.2**
---

> **This datapack is considered safe to use, but it is still actively receiving security improvements, bug fixes, and new features. Please keep it up to date.**
>
> **Do not copy `datalib:input` or `datalib:engine` into your own datapack.** It is an internal implementation detail and may change without notice between releases.

> ⚠️ **Do not use v5.1.1.** That version bound `_rt_origin.mcfunction` to the load tag, causing it to run automatically on every load with no safe removal path. Fixed in later versions — always use the latest release.

---

> ⚠️ A `/reload` is still required after installation or after adding the load hook below. Automatic first-join initialization is not implemented in this version — do not rely on this until verified in-game with repeated reloads.

---

> 🛡️ **This is a Minecraft Datapack — it contains no executables or scripts outside of `.mcfunction` files.**
> Some antivirus software may flag `.mcfunction` files as suspicious due to macro-like syntax. This is a **false positive**. The pack has been scanned on [VirusTotal](https://www.virustotal.com) and returned clean.
> **Only download from this official repository.** Do not trust redistributed or repackaged versions from third-party sources.

---

## 📌 Version targeting note

Active development is currently frozen at **Minecraft 26.2** and macro-free (`$$(cmd)` is not used), pending improvements to Mojang's datapack internal gate mechanisms. Newer Minecraft versions (26.x and beyond) are monitored and researched, but are not the active development target until those improvements land.

---

## 📦 Installation

1. Download the latest release from the [Modrinth versions page](https://modrinth.com/datapack/datalib/versions) and place the `.zip` into `<world>/datapacks/`.

2. Add the following logic to your datapack's `load` tag. Replace `<namespace>` with your own datapack's namespace (e.g. `mypack`) — this applies only to the function names, never to `datalib:engine`, which is dataLib's own fixed storage and must not be changed:

```mcfunction
#> <namespace>:load
execute unless data storage datalib:engine {global:{loaded:1b}} run function <namespace>:load_datalib
```

```mcfunction
#> <namespace>:load_datalib

# Guard checks the SAME storage/path the trigger condition checks (datalib:engine global.loaded).
execute if data storage datalib:engine {global:{loaded:1b}} run return 0

function dl_load:load/yes
function dl_load:load/fork_no

data modify storage datalib:engine global.loaded set value 1b
```

<details>
<summary>Fixed bug: duplicate load trigger (click to expand)</summary>

An earlier version checked `datalib:engine {global:{loaded:1b}}` in the trigger but set `<namespace>:engine loaded_datalib` in the guard — two different storages, two different paths. The set never satisfied the trigger's condition, so `load_datalib` re-ran every time the load tag fired. This doesn't crash anything, but it silently re-triggers `dl_load:load/yes` and `fork_no` on every reload, which can accumulate side effects depending on what those functions do.

Both the check and the set must target `datalib:engine global.loaded`. If you're updating from an older copy of this README, verify by reloading multiple times and confirming `load_datalib` does NOT re-run after the first load.

</details>

---

## 🏗️ Storage Architecture

```
datalib:engine  (persistent data)
├── global
│   ├── version: "v6.0.2"
│   ├── loaded: 1b
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

**Note:** All dataLib-owned state lives under the `datalib:` namespace only. Never mix a consuming pack's own namespace into dataLib's load-flag logic — that mismatch was the source of the bug above.

---

## 📦 Dependencies

### Lantern Load
**Repository:** https://github.com/LanternMC/load
**License:** BSD 0-Clause (public domain)

Provides deterministic load order, version tracking, and pre/load/post-load hooks.

```mcfunction
# Check if dataLib is loaded
execute if score #dataLib load.status matches 1.. run say dataLib is loaded

# Get version (major*10000 + minor*100 + patch → v6.0.2 = 601)
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

## 💬 Support

[![Issues](https://img.shields.io/github/issues/runtoolkit/dataLib-dp?style=for-the-badge)](https://github.com/runtoolkit/dataLib-dp/issues)
[![Discussions](https://img.shields.io/github/discussions/runtoolkit/dataLib-dp?style=for-the-badge&logo=github&color=blue)](https://github.com/runtoolkit/dataLib-dp/discussions)

---

*dataLib v6.0.2 | MC Java 26.2 | Pure Datapack*
