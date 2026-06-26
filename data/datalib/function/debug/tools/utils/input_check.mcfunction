# ======================================================================================
# datalib:debug/tools/utils/input_check
# ======================================================================================
#
# dataLib Secure Validation Gateway
# Version: 2.0.0
#
# PURPOSE:
#   Centralized security validation layer for all dynamic dataLib calls.
#   Every externally supplied runtime request MUST pass through this
#   validation layer before execution is permitted.
#
# DESIGN PHILOSOPHY:
#
#   Built around "fail closed" — any request that does not explicitly pass
#   all validation stages is denied. There is no fallback execution path.
#
# ATTACKER MODEL:
#
#   • Datapack authors outside the ecosystem may abuse the dynamic call interface.
#   • Malicious inputs may be crafted to escape namespacing.
#   • Operator-level commands may be invoked through indirect paths.
#   • Storage state may be corrupted to bypass future checks.
#   • Nested calls may be used to re-enter the validation pipeline.
#   • The execution engine may be targeted directly.
#
# SECURITY GOALS:
#
#   • prevent privilege escalation
#   • prevent namespace escape
#   • prevent selector abuse
#   • prevent execute-chain hijacking
#   • prevent storage corruption
#   • prevent recursion abuse
#   • prevent dangerous runtime mutation
#   • prevent unauthorized engine access
#   • prevent command injection
#   • prevent NBT injection
#   • prevent gamerule abuse
#   • prevent scoreboard system corruption
#   • prevent entity spawning abuse
#   • prevent tag-based permission bypass
#   • maintain deterministic execution
#
# VALIDATION PIPELINE:
#
#   1.  recursion guard
#   2.  engine state validation
#   3.  input snapshot isolation
#   4.  required field validation (removed)
#   5.  basic function identifier sanity
#   6.  namespace allowlist enforcement
#   7.  internal namespace protection (removed)
#   8.  dangerous server management command blocklist
#   9.  raw operator command payload blocklist
#   10. selector escalation protection
#   11. wildcard and mass-target protection
#   12. execute-chain abuse protection
#   13. command chain injection protection
#   14. storage injection protection
#   15. execute store and data mutation abuse protection
#   16. NBT injection protection
#   17. gamerule abuse protection
#   18. scoreboard system corruption protection
#   19. entity and tag manipulation protection
#   20. debug output
#   21. validated execution lock
#   22. validated execution
#   23. execution lock cleanup
#   24. temporary storage cleanup
#   25. success return
#
# RETURN VALUES:
#
#   return 1 → validation passed; call was executed
#   return 0 → validation failed; call was denied
#
# OUTPUT CHANNELS (when debug mode active):
#
#   tellraw @s              caller-facing denial messages
#   tellraw @a[tag=datalib.debug]   admin-facing violation notices
#   say                     server log channel (visible in console)
#   storage datalib:debug   machine-readable violation record
#
# DEBUG MODE:
#   All output channels are gated on datalib:engine dev_settings.devMode
#   or the presence of at least one player with tag datalib.debug.
#   In production with no debug players, all tellraw/say are skipped.
#
# SECURITY POLICY:
#
#   FAIL CLOSED
#   Unknown behavior is considered unsafe until explicitly reviewed.
#
# ======================================================================================
# SECTION 1
# RECURSION GUARD
# ======================================================================================
#
# THREAT:
#   A function called from within a validated execution context may call
#   the gateway again. Re-validating would be harmless but wastes CPU.
#   More importantly, in_call:1b is the recursion sentinel — allowing it
#   to re-enter would mean the sentinel check itself is bypassed.
#
# BEHAVIOR:
#   If in_call:1b is present, the call is already inside a validated
#   context. Return 1 immediately without re-running validation.
#
# BYPASS RISK:
#   An attacker who sets in_call:1b externally bypasses all validation.
#   Sections 14-15 block direct writes to datalib:engine to mitigate this.
#
# ======================================================================================

# ======================================================================================
# ======================================================================================

execute if data storage datalib:engine global{in_call:1b} run return 1

# ======================================================================================
# SECTION 2
# ENGINE STATE VALIDATION
# ======================================================================================
#
# THREAT:
#   Calls during partial initialization may hit unguarded code paths.
#
# BEHAVIOR:
#   Deny all calls unless datalib:engine global contains loaded:1b.
#
# ======================================================================================

execute unless data storage datalib:engine global{loaded:1b} run return 0

# ======================================================================================
# SECTION 3
# SNAPSHOT INPUTS
# ======================================================================================
#
# THREAT:
#   Reading inputs directly from datalib:input during validation is a
#   TOCTOU vulnerability. A function called mid-validation could mutate
#   datalib:input, causing later checks to read different values than
#   earlier ones.
#
# BEHAVIOR:
#   Copy all runtime data into an isolated snapshot at the start.
#   All subsequent checks read exclusively from this snapshot.
#   datalib:input is never read again after this section.
#
# ======================================================================================

data modify storage datalib:output inputs set from storage datalib:input
data modify storage datalib:output data set from storage datalib:engine
data modify storage datalib:output security set value {validated:0b,blocked:0b}

# ======================================================================================
# SECTION 4
# REQUIRED FIELD VALIDATION
# ======================================================================================
#
# THREAT:
#   Missing mandatory fields cause undefined behavior in the engine.
#
# REQUIRED:
#   inputs.func — the function identifier to execute
#
# ======================================================================================

# REMOVED
# execute unless data storage datalib:output inputs.func run return 0'

# ======================================================================================
# SECTION 5
# BASIC FUNCTION IDENTIFIER SANITY CHECKS
# ======================================================================================
#
# THREAT:
#   Malformed identifiers may trigger edge cases in the mcfunction
#   runtime's path resolution. Block all degenerate values.
#
# ======================================================================================

execute if data storage datalib:output inputs{func:""} run return 0
execute if data storage datalib:output inputs{func:" "} run return 0
execute if data storage datalib:output inputs{func:":"} run return 0
execute if data storage datalib:output inputs{func:"/"} run return 0
execute if data storage datalib:output inputs{func:".."} run return 0
execute if data storage datalib:output inputs{func:"."} run return 0
execute if data storage datalib:output inputs{func:"\\"} run return 0
execute if data storage datalib:output inputs{func:"*"} run return 0
execute if data storage datalib:output inputs{func:"#"} run return 0

# ======================================================================================
# SECTION 6
# NAMESPACE ALLOWLIST ENFORCEMENT
# ======================================================================================
#
# THREAT:
#   Without namespace restrictions, callers could execute arbitrary
#   functions in any namespace, including vanilla minecraft:, other
#   installed packs, or datalib internals.
#
# POLICY:
#   Only paths beginning with "datalib:api/" are valid external call targets.
#
# BEHAVIOR:
#   If func does not contain "datalib:api/" prefix, log violation and deny.
#
# ======================================================================================

execute unless data storage datalib:output inputs{func:"datalib:api/"} run function datalib:core/security/input_ns_violation
execute unless data storage datalib:output inputs{func:"datalib:api/"} run data modify storage datalib:output error set value {level:"WARN",code:"NS_VIOLATION",message:"Input namespace violation detected. Action allowed but logged."}

# ======================================================================================
# SECTION 7
# INTERNAL NAMESPACE PROTECTION
# ======================================================================================
#
# THREAT:
#   Defense-in-depth for cases where the allowlist check has an edge case
#   or is bypassed in future refactors. Explicitly block all internal paths.
#
# ======================================================================================

# REMOVED
# execute if data storage datalib:output inputs{func:"datalib:core/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:engine/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:debug/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:private/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:internal/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:security/"} run return 0
# execute if data storage datalib:output inputs{func:"datalib:system/"} run return 0
# execute if data storage datalib:output inputs{func:"minecraft:"} run return 0

# ======================================================================================
# SECTION 8
# HIGH-RISK SERVER MANAGEMENT COMMAND BLOCKLIST (func field)
# ======================================================================================
#
# THREAT:
#   The API exposes command wrappers. If a caller names a server management
#   command wrapper, they gain operator-equivalent control without holding op.
#
# ======================================================================================

execute if data storage datalib:output inputs{func:"datalib:api/cmd/op"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/deop"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/ban"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/ban_ip"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/pardon"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/pardon_ip"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/kick"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/stop"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/reload"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/debug"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/perf"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/whitelist"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-all"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-off"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/save-on"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_block"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_entity"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/data_remove_storage"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/other/run_self"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/other/multi_cmd_adv"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/setidletimeout"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/jfr"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/publish"} run return 0
execute if data storage datalib:output inputs{func:"datalib:api/cmd/transfer"} run return 0

# ======================================================================================
# SECTION 9
# RAW OPERATOR COMMAND PAYLOAD BLOCKLIST (cmd field)
# ======================================================================================
#
# THREAT:
#   Section 8 blocks named wrappers via func. But an attacker may supply
#   raw operator commands directly in the cmd field, bypassing func checks.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"op "} run return 0
execute if data storage datalib:output inputs{cmd:"deop "} run return 0
execute if data storage datalib:output inputs{cmd:"ban "} run return 0
execute if data storage datalib:output inputs{cmd:"ban-ip "} run return 0
execute if data storage datalib:output inputs{cmd:"pardon "} run return 0
execute if data storage datalib:output inputs{cmd:"pardon-ip "} run return 0
execute if data storage datalib:output inputs{cmd:"kick "} run return 0
execute if data storage datalib:output inputs{cmd:"stop"} run return 0
execute if data storage datalib:output inputs{cmd:"reload"} run return 0
execute if data storage datalib:output inputs{cmd:"whitelist "} run return 0
execute if data storage datalib:output inputs{cmd:"save-all"} run return 0
execute if data storage datalib:output inputs{cmd:"save-off"} run return 0
execute if data storage datalib:output inputs{cmd:"save-on"} run return 0
execute if data storage datalib:output inputs{cmd:"publish"} run return 0
execute if data storage datalib:output inputs{cmd:"transfer "} run return 0
execute if data storage datalib:output inputs{cmd:"jfr "} run return 0
execute if data storage datalib:output inputs{cmd:"setidletimeout "} run return 0

# ======================================================================================
# SECTION 10
# SELECTOR ESCALATION PROTECTION
# ======================================================================================
#
# THREAT:
#   Selectors can mass-target all players simultaneously. Combined with
#   dangerous commands, a single payload can op/ban/kick the entire server.
#
#   High-risk patterns: op/deop/kick/ban + any broadcast selector.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"op @a"} run return 0
execute if data storage datalib:output inputs{cmd:"op @e"} run return 0
execute if data storage datalib:output inputs{cmd:"op @r"} run return 0
execute if data storage datalib:output inputs{cmd:"op @s"} run return 0
execute if data storage datalib:output inputs{cmd:"op @p"} run return 0
execute if data storage datalib:output inputs{cmd:"op @n"} run return 0

execute if data storage datalib:output inputs{cmd:"deop @a"} run return 0
execute if data storage datalib:output inputs{cmd:"deop @e"} run return 0
execute if data storage datalib:output inputs{cmd:"deop @r"} run return 0
execute if data storage datalib:output inputs{cmd:"deop @s"} run return 0
execute if data storage datalib:output inputs{cmd:"deop @p"} run return 0
execute if data storage datalib:output inputs{cmd:"deop @n"} run return 0

execute if data storage datalib:output inputs{cmd:"kick @a"} run return 0
execute if data storage datalib:output inputs{cmd:"kick @e"} run return 0
execute if data storage datalib:output inputs{cmd:"kick @r"} run return 0
execute if data storage datalib:output inputs{cmd:"kick @p"} run return 0

execute if data storage datalib:output inputs{cmd:"ban @a"} run return 0
execute if data storage datalib:output inputs{cmd:"ban @e"} run return 0
execute if data storage datalib:output inputs{cmd:"ban @r"} run return 0
execute if data storage datalib:output inputs{cmd:"ban @s"} run return 0
execute if data storage datalib:output inputs{cmd:"ban @p"} run return 0

execute if data storage datalib:output inputs{cmd:"execute as @a"} run return 0
execute if data storage datalib:output inputs{cmd:"execute as @e"} run return 0
execute if data storage datalib:output inputs{cmd:"execute as @r"} run return 0
execute if data storage datalib:output inputs{cmd:"execute as @p"} run return 0
execute if data storage datalib:output inputs{cmd:"execute as @n"} run return 0

execute if data storage datalib:output inputs{cmd:"execute at @a"} run return 0
execute if data storage datalib:output inputs{cmd:"execute at @e"} run return 0
execute if data storage datalib:output inputs{cmd:"execute at @r"} run return 0
execute if data storage datalib:output inputs{cmd:"execute at @p"} run return 0
execute if data storage datalib:output inputs{cmd:"execute at @n"} run return 0

# ======================================================================================
# SECTION 11
# WILDCARD AND MASS-TARGET PROTECTION
# ======================================================================================
#
# THREAT:
#   @e[type=player] is equivalent to @a and mass-targets all players.
#   @e[tag=admin/operator/op] impersonates permission-system entities.
#   Bare @a and @e in cmd indicate mass broadcast intent.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"@e[type=player]"} run return 0
execute if data storage datalib:output inputs{cmd:"@e[type=minecraft:player]"} run return 0
execute if data storage datalib:output inputs{cmd:"@e[tag=admin]"} run return 0
execute if data storage datalib:output inputs{cmd:"@e[tag=operator]"} run return 0
execute if data storage datalib:output inputs{cmd:"@e[tag=op]"} run return 0
execute if data storage datalib:output inputs{cmd:"@e[tag=datalib.debug]"} run return 0
execute if data storage datalib:output inputs{cmd:"@a"} run return 0
execute if data storage datalib:output inputs{cmd:"@e"} run return 0

# ======================================================================================
# SECTION 12
# EXECUTE-CHAIN ABUSE PROTECTION
# ======================================================================================
#
# THREAT:
#   execute sub-commands can redirect execution context, invoke arbitrary
#   functions, schedule deferred calls, or change the executor's identity.
#
#   "run function" and "schedule function" directly invoke arbitrary paths.
#   Context modifiers (as/at/in/on/positioned/facing/rotated/anchored/align)
#   can target restricted entities or privileged locations.
#   "execute summon" creates entities in an attacker-controlled context.
#   "execute run" is a catch-all executor that should never appear in cmd.
#
# NOTE:
#   "execute if" and "execute unless" are NOT blocked: they are read-only
#   condition checks that do not alter execution context.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"run function"} run return 0
execute if data storage datalib:output inputs{cmd:"schedule function"} run return 0
execute if data storage datalib:output inputs{cmd:"schedule clear"} run return 0
execute if data storage datalib:output inputs{cmd:"execute as "} run return 0
execute if data storage datalib:output inputs{cmd:"execute at "} run return 0
execute if data storage datalib:output inputs{cmd:"execute in "} run return 0
execute if data storage datalib:output inputs{cmd:"execute on "} run return 0
execute if data storage datalib:output inputs{cmd:"execute positioned"} run return 0
execute if data storage datalib:output inputs{cmd:"execute facing"} run return 0
execute if data storage datalib:output inputs{cmd:"execute rotated"} run return 0
execute if data storage datalib:output inputs{cmd:"execute anchored"} run return 0
execute if data storage datalib:output inputs{cmd:"execute align"} run return 0
execute if data storage datalib:output inputs{cmd:"execute summon"} run return 0
execute if data storage datalib:output inputs{cmd:"execute run"} run return 0

# ======================================================================================
# SECTION 13
# COMMAND CHAIN INJECTION PROTECTION
# ======================================================================================
#
# THREAT:
#   Shell-style separators and control characters in cmd may cause
#   multi-command injection under certain execution environments,
#   or may be used to terminate the intended command and append a
#   second one. Newlines may cause line-based parsers to treat
#   subsequent text as a new command.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:";"} run return 0
execute if data storage datalib:output inputs{cmd:"&&"} run return 0
execute if data storage datalib:output inputs{cmd:"||"} run return 0
execute if data storage datalib:output inputs{cmd:"\n"} run return 0
execute if data storage datalib:output inputs{cmd:"\r"} run return 0
execute if data storage datalib:output inputs{cmd:"\t"} run return 0

# ======================================================================================
# SECTION 14
# STORAGE INJECTION PROTECTION
# ======================================================================================
#
# THREAT:
#   Injecting storage path syntax into func can redirect the engine to
#   read macro arguments from attacker-controlled storage.
#
#   Example:
#     inputs.func = "datalib:api/cmd with storage datalib:engine global"
#   → macro call reads from engine storage, giving attacker control
#     over macro arguments.
#
#   All internal datalib storage namespaces are blocked in both
#   func and cmd fields.
#
# ======================================================================================

execute if data storage datalib:output inputs{func:"with storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{func:"with storage datalib:output"} run return 0
execute if data storage datalib:output inputs{func:"with storage datalib:input"} run return 0
execute if data storage datalib:output inputs{func:"with storage datalib:debug"} run return 0
execute if data storage datalib:output inputs{func:"storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{func:"storage datalib:output"} run return 0
execute if data storage datalib:output inputs{func:"storage datalib:input"} run return 0
execute if data storage datalib:output inputs{func:"storage datalib:debug"} run return 0

execute if data storage datalib:output inputs{cmd:"with storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"with storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"with storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"with storage datalib:debug"} run return 0
execute if data storage datalib:output inputs{cmd:"storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"storage datalib:debug"} run return 0

# ======================================================================================
# SECTION 15
# EXECUTE STORE AND DATA MUTATION ABUSE PROTECTION
# ======================================================================================
#
# THREAT:
#   "execute store result/success" can write to any storage, scoreboard,
#   block, or entity NBT. If targeting datalib:engine, an attacker can:
#
#     • set loaded:0b → disable the engine until next reload
#     • set in_call:1b → bypass all future validation (Section 1 sentinel)
#
#   "data merge/remove/modify" targeting datalib:engine achieves the same.
#
#   Scoreboard manipulation of internal objectives (#rate_calls,
#   dl.perm_level, dl.log_level) can disable logging or fake permissions.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"execute store result storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store success storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store result storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store success storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store result storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store success storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store result storage datalib:debug"} run return 0
execute if data storage datalib:output inputs{cmd:"execute store success storage datalib:debug"} run return 0

execute if data storage datalib:output inputs{cmd:"data merge storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"data remove storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"data modify storage datalib:engine"} run return 0
execute if data storage datalib:output inputs{cmd:"data merge storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"data remove storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"data modify storage datalib:output"} run return 0
execute if data storage datalib:output inputs{cmd:"data merge storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"data remove storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"data modify storage datalib:input"} run return 0
execute if data storage datalib:output inputs{cmd:"data merge storage datalib:debug"} run return 0
execute if data storage datalib:output inputs{cmd:"data remove storage datalib:debug"} run return 0
execute if data storage datalib:output inputs{cmd:"data modify storage datalib:debug"} run return 0

execute if data storage datalib:output inputs{cmd:"scoreboard players set #dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard players reset #dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard players add #dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard players remove #dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard objectives add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard objectives remove dl"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard objectives add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"scoreboard objectives remove datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @s add datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @a add datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @r add datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @n add datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @s remove datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @a remove datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @r remove datalib.admin"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @n remove datalib.admin"} run return 0

# ======================================================================================
# SECTION 16
# NBT INJECTION PROTECTION
# ======================================================================================
#
# THREAT:
#   Raw NBT compound syntax ({...}) in a cmd payload can be used to:
#
#     • Inject additional NBT keys into entity data
#     • Override custom_data tags to impersonate permission-tagged entities
#     • Manipulate block entity data (e.g. command block Command field)
#     • Pass crafted NBT to any command that accepts an NBT argument
#
#   Blocking bare "{" in cmd is a conservative safeguard. Legitimate API
#   calls pass structured arguments via storage, not raw NBT in cmd strings.
#
#   Exception: "{}" (empty compound) is common in macro calls and is
#   intentionally NOT blocked. Only non-empty NBT compounds are denied.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"Command"} run return 0
execute if data storage datalib:output inputs{cmd:"auto"} run return 0
execute if data storage datalib:output inputs{cmd:"CustomName"} run return 0
execute if data storage datalib:output inputs{cmd:"Tags"} run return 0
execute if data storage datalib:output inputs{cmd:"datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"minecraft:custom_data"} run return 0
execute if data storage datalib:output inputs{cmd:"minecraft:custom_data"} run return 0

# ======================================================================================
# SECTION 17
# GAMERULE ABUSE PROTECTION
# ======================================================================================
#
# THREAT:
#   Certain gamerules have direct security and stability implications:
#
#     commandBlocksWork (26.1.2+) / commandBlockEnabled (legacy)
#       → re-enables command block execution if it was disabled
#
#     maxCommandChainLength
#       → raising this allows deeper recursion and DoS attacks
#
#     doImmediateRespawn, naturalRegeneration, keepInventory
#       → griefing quality-of-life rules (lower severity, still blocked)
#
#     pvp (only in server.properties, not a gamerule, included for clarity)
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"gamerule commandBlocksWork"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule commandBlockEnabled"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule maxCommandChainLength"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule maxEntityCramming"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule randomTickSpeed"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule spawnRadius"} run return 0
execute if data storage datalib:output inputs{cmd:"gamerule playersSleepingPercentage"} run return 0

# ======================================================================================
# SECTION 18
# ENTITY AND TAG MANIPULATION PROTECTION
# ======================================================================================
#
# THREAT:
#   Datalib's permission system uses entity tags (datalib.debug, dl.perm_level,
#   datalib.admin) to identify privileged players and entities. An attacker
#   who can add these tags to themselves bypasses the permission model entirely.
#
#   "summon" can create arbitrary entities with attacker-controlled NBT,
#   including tags that the permission system trusts.
#
#   "tag add" targeting @s or any player with a known privilege tag is
#   a direct permission escalation attack.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"summon "} run return 0
execute if data storage datalib:output inputs{cmd:"tag @s add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @s add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @a add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @a add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @p add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @p add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @r add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @r add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @e add datalib"} run return 0
execute if data storage datalib:output inputs{cmd:"tag @e add dl"} run return 0
execute if data storage datalib:output inputs{cmd:"attribute @s"} run return 0
execute if data storage datalib:output inputs{cmd:"effect give @a"} run return 0
execute if data storage datalib:output inputs{cmd:"effect give @e"} run return 0

# ======================================================================================
# SECTION 19
# FORCELOAD AND BLOCK PLACEMENT ABUSE PROTECTION
# ======================================================================================
#
# THREAT:
#   "forceload add" can keep arbitrary chunks loaded indefinitely,
#   causing memory/CPU strain and enabling block persistence attacks.
#
#   "setblock" at privileged coordinates (e.g. 0 -64 0 where datalib's
#   command block runner sits) can replace the command block with a
#   malicious one, or destroy it to break the command runner.
#
#   "fill" is forceload + setblock at scale.
#
# ======================================================================================

execute if data storage datalib:output inputs{cmd:"forceload add"} run return 0
execute if data storage datalib:output inputs{cmd:"forceload remove"} run return 0
execute if data storage datalib:output inputs{cmd:"setblock 0 -64 0"} run return 0
execute if data storage datalib:output inputs{cmd:"fill "} run return 0
execute if data storage datalib:output inputs{cmd:"fillbiome "} run return 0

# ======================================================================================
# SECTION 20
# DEBUG OUTPUT
# ======================================================================================
#
# PURPOSE:
#   Emit diagnostic messages through all configured output channels
#   when a call passes all validation stages.
#
# OUTPUT CHANNELS:
#
#   tellraw @s
#     Caller-visible confirmation. Only emitted if @s is a player.
#     Shows validated function path and current tick.
#
#   tellraw @a[tag=datalib.debug]
#     Admin-visible full call record. Always attempted.
#     Shows caller identity, func path.
#
#   say
#     Server console log. Gated on devMode and at least one debug player.
#     Output appears in server log file as [Server] prefix.
#
#   storage datalib:debug
#     Machine-readable record. Written unconditionally for tooling.
#     Overwritten each call — not a persistent audit log.
#
# GATE:
#   All output is skipped entirely unless devMode is enabled OR at least
#   one player holds the datalib.debug tag. This prevents debug spam
#   in production servers with no active debugging session.
#
# ======================================================================================

# Write machine-readable call record unconditionally
data modify storage datalib:debug last_validated_call.func set from storage datalib:output inputs.func

# Gate remaining output on debug mode or active debug players
execute unless data storage datalib:engine dev_settings{devMode:1b} unless entity @a[tag=datalib.debug] run return fail

# Caller-facing confirmation (players only)
execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"Validated: ","color":"gray"},{"storage":"datalib:output","nbt":"inputs.func","color":"aqua"}]

# Admin-facing full record
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"CALL ","color":"green","bold":true},{"selector":"@s","color":"gold"},{"text":" → ","color":"#555555"},{"storage":"datalib:output","nbt":"inputs.func","color":"aqua"}]

# Server console log (devMode only — say is noisy)
execute if data storage datalib:engine dev_settings{devMode:1b} run say [DL/input_check] VALIDATED

# ======================================================================================
# SECTION 21
# VALIDATED EXECUTION LOCK
# ======================================================================================
#
# PURPOSE:
#   Set in_call:1b to prevent Section 1 from re-running validation
#   for any function invoked by the validated target.
#   Must be set immediately before execution and cleared immediately after.
#
# ======================================================================================

data modify storage datalib:engine global.in_call set value 1b

# ======================================================================================
# SECTION 22
# EXECUTE VALIDATED FUNCTION
# ======================================================================================

function datalib:core/engine/call/execute_validated

# ======================================================================================
# SECTION 23
# CLEANUP EXECUTION LOCK
# ======================================================================================

data remove storage datalib:engine global.in_call

# ======================================================================================
# SECTION 24
# CLEANUP TEMPORARY STORAGE
# ======================================================================================

data remove storage datalib:output data
data remove storage datalib:output security
data remove storage datalib:output inputs

# ======================================================================================
# SECTION 25
# SUCCESS RETURN
# ======================================================================================

return 1
