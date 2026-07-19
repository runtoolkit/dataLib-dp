# CHANGELOG — v6.0.1-pre2

## Load pipeline restructuring

- **`dl_load:_` renamed to `dl_load:main`.** This is now the single function
  registered as dataLib's real entry point (`datalib:load` → `dl_load:main`).
  All internal references and doc comments across `dl_load:*` were updated
  accordingly.
- **New `dl_load:resolve/*` module** — version and dependency resolution,
  split out of the old monolithic `core/internal/load/validate.mcfunction`
  (now removed):
  - `dl_load:resolve/validate` — orchestrator, same call contract as the old
    `core/internal/load/validate` (returns 1 = continue, 0 = abort).
  - `dl_load:resolve/version` — compares any stale `dl.pre_version` scores
    left over from a previous load pass in the same server session against
    this build's expected version.
  - `dl_load:resolve/dependencies` — rt_origin/fork detection and the
    optional StringLib dependency check.
- **New `dl_load:loader/*` module** — the actual scoreboard/storage
  initialization routines, moved out of `dl_load:load/*` so that `load/*`
  is now exclusively the confirmation-gate layer (`confirm`, `yes`, `no`,
  `fork*`, `post_load`) while `loader/*` holds the init routines it
  delegates to:
  - `dl_load:load/scoreboards` → `dl_load:loader/scoreboards`
  - `dl_load:load/storages` → `dl_load:loader/storages`
  All call sites (`load/all.mcfunction`, `load/yes.mcfunction` comments)
  were updated to the new paths.

## Marker-entity + `say` removal (lag reduction)

Every function under `dl_load:*` previously summoned a `minecraft:marker`
entity, ran `say` through it, then killed it — on every single broadcast,
including 9 separate stage markers in `load/all.mcfunction` alone on every
world load/reload. This pattern existed because `say` has no
`@a[tag=...]` selector filter and, historically, `tellraw`/`clickEvent`
rendering was considered unreliable during server startup.

All of it has been replaced with plain `tellraw`, which needs no
executing entity and can be scoped to `@a[tag=datalib.debug]` for
debug-tier messages instead of broadcasting to every player. This removes
the summon/kill entity churn entirely from the load path.

Affected files (marker+`say` → `tellraw`):
`dl_load:main` (formerly `_`), `load/confirm`, `load/yes`, `load/no`,
`load/fork`, `load/fork_yes`, `load/fork_no`, `load/post_load`,
`load/all`, `timeout`, `gate/request`, `gate/yes`, `gate/no`,
`gate/timeout`, `gate/exec/disable`, `safe_load/yes`, `safe_load/no`.

## Clickable confirmation buttons

Gate prompts (`load/confirm`, `load/no`, `load/fork`, `gate/request`,
`gate/exec/disable`) now render actual clickable `[Confirm]`/`[Cancel]`/
`[Yes]`/`[No]`/`[Retry Load]` buttons using:

```json
{"click_event": {"action": "run_command", "command": "/function dl_load:load/yes"}}
```

This is the current Minecraft text-component format as of 1.21.5+: the
`run_command` click event's payload field was renamed `value` → `command`
(and the leading `/` is now optional, though still included here for
clarity), and the event field itself was renamed `clickEvent` →
`click_event` (`hoverEvent` → `hover_event` likewise, though dataLib does
not currently use hover events in the load path). Text still reads and
runs correctly by hand for admins who prefer typing the command directly.

## Bug fixes

- **`resolve/version` (was `core/internal/load/validate`) self-defeating
  mismatch check.** The old comparison flagged a mismatch whenever
  `#dl.pre` was `1` or higher (`matches 1..`) — but this pack's own
  expected `pre` value is always ≥ 1, so a correctly-stamped scoreboard
  from an earlier pass in the same session would trip the mismatch flag
  against itself. It now compares against the exact expected `pre` value,
  consistent with how `major`/`minor`/`patch` are already checked.
- **`load/version_warn` stale expected-version numbers.** The debug line
  printed `(expected: 6 0 0 pre=0)` unconditionally, which never matched
  what `core/internal/load/version_set` actually stamps (`patch=1`,
  `pre=1` under pre1). Updated to reflect the real expected values for
  this release (`patch=1`, `pre=2`).

## Version bump

- `pack.mcmeta` description and `README.md`: `v6.0.1-pre1` → `v6.0.1-pre2`
- `dl_load:core/internal/load/version_set`: `#dl.pre` `1` → `2`
- `dl_load:resolve/validate`: `datalib:engine global.version` stamp updated
  to `"v6.0.1-pre2"`
- All hardcoded version strings in load-path warning/error messages
  (`resolve/version`, `core/internal/load/version_warn`,
  `load/version_warn`) updated to match

## Gate: kick executor added

`dl_load:gate/yes` previously only dispatched `"ban"`, `"ban_ip"`, and
`"disable"` — a `pending_gate{type:"kick"}` matched none of the dispatch
conditions and silently no-opped after cleanup, with no error or warning.
Added `dl_load:gate/exec/kick` and its dispatch line:

```mcfunction
data modify storage datalib:engine pending_gate set value {type:"kick", player:"<name>", reason:"<text>"}
function dl_load:gate/request
```

## Configurable admin debug-tag auto-grant

Previously `datalib:core/tick/admin_systems` unconditionally ran
`tag @a[tag=datalib.admin] add datalib.debug` every tick — every admin
got `datalib.debug` (and therefore every `tellraw @a[tag=datalib.debug]`
message across the load path) with no way to opt out short of editing
the datapack.

This is now gated behind `datalib:engine security.auto_debug_tag`
(new field, default `1b` — preserves existing behavior):

- `1b` (default): unchanged, every admin gets `datalib.debug` automatically.
- `0b`: auto-grant stops; use the new commands to manage it manually:
  - `/function datalib:debug/tools/admin/debug_tag/enable` — back to auto (1b)
  - `/function datalib:debug/tools/admin/debug_tag/disable` — turn off auto (0b) and strip `datalib.debug` from all current admins immediately
  - `/function datalib:debug/tools/admin/debug_tag/grant {target:"Name"}` — give one player `datalib.debug`
  - `/function datalib:debug/tools/admin/debug_tag/revoke {target:"Name"}` — remove it from one player

Worlds upgrading from an earlier build get `auto_debug_tag` backfilled
to `1b` on next load (existing `security` compounds are missing the
field entirely, and the top-level `unless data storage ... security`
guard only fires when the whole compound is absent).

## Compatibility

No breaking changes to external call sites. `dl_load:load/yes`,
`dl_load:load/no`, `dl_load:load/fork_yes`, `dl_load:load/fork_no`,
`dl_load:gate/*`, and `dl_load:safe_load/*` keep their existing names and
contracts — only the internal `dl_load:_` entry point and the
`load/scoreboards` / `load/storages` internals moved. If any external
pack calls `dl_load:_` or `dl_load:load/scoreboards` /
`dl_load:load/storages` directly (undocumented — the public entry point
has always been `datalib:load` per the README installation snippet),
update those calls to `dl_load:main` / `dl_load:loader/scoreboards` /
`dl_load:loader/storages`.
