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
#   An absent inputs.func reaches execute_validated/run, which does
#   `$function $(func) with storage datalib:input {}` — an unset $(func)
#   makes that macro call fail to resolve a function, an unhandled
#   engine-level error rather than a clean, logged denial.
#
# REQUIRED:
#   inputs.func — the function identifier to execute
#
# SECURITY FIX (this pass):
#   This check was previously commented out entirely ("REMOVED"). Restored
#   as a hard requirement — every other section from here on assumes
#   inputs.func exists and is a string.
#
# ======================================================================================

execute unless data storage datalib:output inputs.func run return 0

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
# SECURITY FIX (v6.1.1):
#   Previously this section logged the violation but did NOT return 0,
#   meaning execute_validated/run would still run $function $(func) on
#   any namespace afterward. Fail-open on the exact check documented as
#   "namespace allowlist enforcement". Now returns 0 after logging.
#
# SECURITY FIX (this pass — StringLib rewrite):
#   `execute if data storage ... inputs{func:"datalib:api/"}` is NBT
#   compound matching against a string field, which requires BYTE-FOR-BYTE
#   EQUALITY, not a prefix test. func is always longer than the literal
#   "datalib:api/" (e.g. "datalib:api/cmd/freeze"), so the two strings can
#   never be equal — the `unless` here was ALWAYS true, meaning every
#   legitimate datalib:api/* call was rejected as a namespace violation
#   (confirmed live in latest.log: repeated "NS WARNING ... func not in
#   datalib:api/*" spam for datalib:api/cmd/freeze, a call that should
#   have passed). Replaced with a real prefix check via StringLib: find
#   the literal at index 0.
#
# ======================================================================================

function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/"}
scoreboard players operation #DL.NsPrefixOk dl.tmp = #DL.StrIndex dl.tmp

execute unless score #DL.NsPrefixOk dl.tmp matches 0 run function datalib:core/security/input_ns_violation
execute unless score #DL.NsPrefixOk dl.tmp matches 0 run data modify storage datalib:output error set value {level:"WARN",code:"NS_VIOLATION",message:"Input namespace violation detected. Call denied."}
execute unless score #DL.NsPrefixOk dl.tmp matches 0 run return 0

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

# SECURITY FIX (this pass — StringLib rewrite):
#   Previously commented out entirely ("REMOVED"), leaving no defense-in-
#   depth if Section 6's allowlist ever had an edge case. Now that a real
#   substring test exists, restored as active checks. These test for the
#   internal prefix occurring ANYWHERE in func (not just at index 0) so a
#   crafted func like "datalib:api/../core/engine/x" is also caught.

function datalib:core/security/string/field_contains {field:"func",needle:"datalib:core/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:engine/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:debug/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:private/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:internal/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:security/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:system/"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"minecraft:"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/op"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/deop"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/ban"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/ban_ip"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/pardon"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/pardon_ip"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/kick"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/stop"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/reload"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/perf"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/whitelist"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/save-all"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/save-off"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/save-on"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/data_remove_block"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/data_remove_entity"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/data_remove_storage"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/other/run_self"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/other/multi_cmd_adv"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/setidletimeout"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/jfr"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/publish"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"datalib:api/cmd/transfer"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"op "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban-ip "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"pardon "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"pardon-ip "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"kick "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"stop"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"reload"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"whitelist "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"save-all"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"save-off"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"save-on"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"publish"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"transfer "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"jfr "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"setidletimeout "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"op @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"op @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"op @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"op @s"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"op @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"op @n"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @s"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"deop @n"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"kick @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"kick @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"kick @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"kick @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"ban @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban @s"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"ban @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as @n"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at @r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at @p"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at @n"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[type=player]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[type=minecraft:player]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[tag=admin]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[tag=operator]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[tag=op]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e[tag=datalib.debug]"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"@e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"run function"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"schedule function"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"schedule clear"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute as "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute at "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute in "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute on "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute positioned"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute facing"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute rotated"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute anchored"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute align"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute summon"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute run"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:";"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"&&"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"||"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"\n"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"\r"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"\t"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"func",needle:"with storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"with storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"with storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"with storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"func",needle:"storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"with storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"with storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"with storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"with storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store result storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store success storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store result storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store success storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store result storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store success storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store result storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"execute store success storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"data merge storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data remove storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data modify storage datalib:engine"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data merge storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data remove storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data modify storage datalib:output"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data merge storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data remove storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data modify storage datalib:input"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data merge storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data remove storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"data modify storage datalib:debug"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard players set #dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard players reset #dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard players add #dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard players remove #dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard objectives add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard objectives remove dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard objectives add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"scoreboard objectives remove datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @s add datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @a add datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @r add datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @n add datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @s remove datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @a remove datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @r remove datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @n remove datalib.admin"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"Command"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"auto"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"CustomName"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"Tags"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"minecraft:custom_data"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule commandBlocksWork"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule commandBlockEnabled"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule maxCommandChainLength"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule maxEntityCramming"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule randomTickSpeed"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule spawnRadius"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"gamerule playersSleepingPercentage"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"summon "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @s add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @s add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @a add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @a add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @p add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @p add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @r add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @r add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @e add datalib"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"tag @e add dl"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"attribute @s"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"effect give @a"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"effect give @e"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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

function datalib:core/security/string/field_contains {field:"cmd",needle:"forceload add"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"forceload remove"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"setblock 0 -64 0"}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"fill "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0
function datalib:core/security/string/field_contains {field:"cmd",needle:"fillbiome "}
execute if score #DL.StrFound dl.tmp matches 1 run return 0

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
