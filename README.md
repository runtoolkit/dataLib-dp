# 🔧 dataLib
**Minecraft Java Edition 26.2 | Multiplayer-Safe | Pure Datapack**

---
> Current version: **v6.0.0**
---

> [!WARNING]
> **This datapack is considered safe to use, but it is still actively receiving security improvements, bug fixes, and new features. Please keep it up to date.**
>
> **Do not copy `datalib:input` or `datalib:engine` into your own datapack.** It is an internal implementation detail and may change without notice between releases.

---
> 🛡️ **This is a Minecraft Datapack — it contains no executables or scripts outside of `.mcfunction` files.**
> Some antivirus software may flag `.mcfunction` files as suspicious due to macro-like syntax. This is a **false positive**. The pack has been scanned on [VirusTotal](https://www.virustotal.com) and returned clean.
> **Only download from this official repository.** Do not trust redistributed or repackaged versions from third-party sources.

---

## 📦 Installation

```
1. Place dataLib-v6.0.0 into <world>/datapacks/
2. /reload
3. /function dl_load:load/yes
4. /tag @s add datalib.admin
5. /scoreboard players set @a[tag=datalib.admin] dl.perm_level 3
```

---

## 🏗️ Storage Architecture

```
datalib:engine  (persistent data)
├── global
│   ├── version: "v6.0.0"
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

Full reference: [Predicate Reference](../../wiki/Predicate-Reference)

---

## 📦 Dependencies

### Lantern Load
**Repository:** https://github.com/LanternMC/load  
**License:** BSD 0-Clause (public domain)

Provides deterministic load order, version tracking, and pre/load/post-load hooks.

```mcfunction
# Check if dataLib is loaded
execute if score #dataLib load.status matches 1.. run say dataLib is loaded

# Get version (major*10000 + minor*100 + patch → v6.0.0 = 50000)
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

[![Issues](https://img.shields.io/github/issues/runtoolkit/DataLib?style=for-the-badge)](https://github.com/runtoolkit/DataLib/issues)
[![Discussions](https://img.shields.io/github/discussions/runtoolkit/DataLib?style=for-the-badge&logo=github&color=blue)](https://github.com/runtoolkit/DataLib/discussions)

---

*dataLib v6.0.0 | MC Java 26.2 | Pure Datapack*
