# Contributing Guide
Thank you for considering contributing to this Minecraft Java Edition datapack.
This document defines contribution standards, architectural constraints, and review criteria.  
All contributions are evaluated based on stability, performance, security, and long-term maintainability.
---
## Project Philosophy
This datapack prioritizes:
- Deterministic and predictable behavior
- Server-side performance optimization
- Secure and auditable command architecture
- Backward compatibility within supported versions
- Minimal unnecessary tick execution
Contributions that conflict with these principles may be rejected.
---
## Before You Contribute
Ensure the following before opening a pull request:
- You are targeting a supported version (see `SECURITY.md`)
- All changes are tested in a clean world
- No debug scoreboards or temporary storage values remain
- No development-only functions are included
- No experimental snapshot-only features are used
- No performance regression is introduced
---
## Development Standards
### 1. Namespacing
- All functions must use the project namespace.
- No pollution of the `minecraft:` namespace.
- Cross-namespace execution must be justified and documented.
---
### 2. Function Design
- No infinite loops.
- No recursive `execute` chains without guaranteed termination.
- Minimize logic inside `tick` functions.
- Prefer `storage` over unnecessary scoreboards when appropriate.
- Use targeted selectors instead of broad selectors (`@a`, `@e`) whenever possible.
---
### 3. Performance Rules
Contributions must avoid:
- Unbounded `@e` scans
- Nested `execute as @a at @a` patterns
- Heavy NBT checks every tick
- Excessive scoreboard writes
- Redundant function calls per tick
Any measurable performance regression may result in rejection.
---
### 4. Security Expectations
Pull requests must NOT include:
- Hidden command execution
- Permission bypass mechanisms
- Backdoors or obfuscated logic
- Crash triggers or lag exploits
- Storage manipulation outside the defined schema
Security-sensitive changes must include a technical explanation.
---
## Pull Request Process
1. Fork the repository.
2. Create a dedicated feature branch.
3. Keep commits atomic and clearly described.
4. Open a pull request including:
   - Clear description of changes
   - Technical explanation
   - Performance impact analysis
   - Testing steps
   - Relevant logs or screenshots (if applicable)
Incomplete or low-effort pull requests may be closed without review.
---
## Code Style
- Consistent indentation
- No trailing whitespace
- Clear and descriptive function naming
- Comment complex logic
- Avoid redundant or duplicated commands
### Example Function Structure
```mcfunction
# Initialize scoreboard
scoreboard objectives add example dummy
# Controlled execution
execute as @a[scores={example=1..}] run function namespace:feature/run
```
---
## Bug Reports
When opening an issue, include:
* Datapack version
* Minecraft version
* Steps to reproduce
* Expected result
* Actual result
* Relevant logs
Vague or incomplete reports may be closed.
---
## Feature Requests
Feature requests must include:
* Clear use case
* Performance consideration
* Compatibility analysis
* Explanation of alignment with project philosophy
---
## Known Pitfalls & Decisions

This section documents recurring mistakes and deliberate decisions to prevent regressions
and reduce contributor confusion.

### pack_format
Always use the exact `pack_format` value for the target version range.
Do not increment version numbers without a meaningful content change — this breaks
semver-aware compatibility checks and downstream dependency guards.
For multi-version support, use `supported_formats` (≤1.21.4) or `min_format`/`max_format`
at root level (1.21.5+ / pack format 61+). Do not mix both forms.

### Text Component Syntax (`clickEvent` vs `click_event`)
- `clickEvent` — legacy camelCase key, valid in all versions up to and including current.
- `click_event` — new snake_case key introduced in 1.21.5.
Both keys are currently accepted for backward compatibility, but **all new files must use
`click_event`** to remain forward-compatible with future deprecation of the camelCase form.
Do not silently convert one to the other without verifying the target version range.

### Macros and Storage
- `$` prefix is required only on lines that contain a `$(var)` substitution.
  Do not apply it globally.
- `$(var)` accepts strings only — full JSON text components cannot be passed as macro arguments.
  Pre-resolve storage values via `function … with storage` before passing to macros.
- Use `set` (not `append`) on shared storage paths to avoid unintended accumulation.
- Always guard storage initialization with `execute unless data`.

### Fake Files and Unverified Links
Do not reference file paths, download links, or external URLs that have not been verified
to exist. Placeholder domains (e.g. `example.com`, `files.examplecdn.com`) are not
acceptable in documentation or code comments.

### No Version Inflation
Version numbers must reflect actual changes:
- Patch (`x.x.Z`): bug fixes only.
- Minor (`x.Y.0`): new features, backward-compatible.
- Major (`X.0.0`): breaking changes.
Incrementing a version number without a corresponding changelog entry will be rejected.

---
## AI-Assisted Contributions

Using AI tools (ChatGPT, Claude, etc.) to help write code or documentation is allowed,
but contributions must meet the same standards as hand-written code.
AI output is not a substitute for understanding — **you are responsible for everything you submit.**

### Common AI Mistakes to Verify Before Submitting

**pack_format / version numbers**
AI models frequently output incorrect or inconsistent `pack_format` values.
Always verify against the [official wiki](https://minecraft.wiki/w/Pack_format) before submitting.

**Hallucinated links and file references**
AI tools may produce plausible-looking but entirely fake URLs, CDN paths, or file names.
Never include a link or file reference you have not personally verified exists.

**Syntax versioning (`clickEvent` vs `click_event`, camelCase vs snake_case)**
AI models often mix old and new key formats within the same output.
Cross-check all JSON text component keys, NBT keys, and advancement event names
against the target version. See [Known Pitfalls & Decisions](#known-pitfalls--decisions).

**Macro usage**
AI-generated macro functions frequently apply the `$` prefix to non-substitution lines,
or attempt to pass full JSON text components as `$(var)` arguments (not supported).
Review every macro file manually.

**Fabricated wait times and progress claims**
Disregard any AI output that claims a file "is being prepared" or will be ready after a delay.
If the content is not in the response, it does not exist.

**Version inflation**
AI tools tend to increment version numbers across iterations without actual changes.
Use your own judgment for versioning — do not copy version strings from AI output blindly.

### Checklist for AI-Assisted PRs
Before opening a pull request that involved AI assistance:
- [ ] All `pack_format` values manually verified
- [ ] No unverified external links or file paths
- [ ] All text component keys match target version syntax
- [ ] Macro `$` prefix applied only to substitution lines
- [ ] Version number reflects actual change scope
- [ ] Logic understood and tested — not submitted as-is from AI output

---
## What Will Be Rejected
* Snapshot-only features
* Performance-heavy mechanics without justification
* Overengineered abstractions
* Features outside project scope
* Low-effort or poorly tested contributions
---
## Final Review Criteria
All contributions are evaluated based on:
* Stability
* Security
* Performance
* Maintainability
* Architectural consistency
Quality over quantity.
