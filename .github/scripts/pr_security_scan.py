import re, sys, os

changed_files_raw = os.environ.get("CHANGED_FILES", "")
mcf_files = [
    f.strip() for f in changed_files_raw.splitlines()
    if f.strip().endswith(".mcfunction") and os.path.isfile(f.strip())
]

# --- Bypass: repo admin PR açtıysa fail etme, sadece warn ---
PR_AUTHOR_IS_ADMIN = os.environ.get("PR_AUTHOR_IS_ADMIN", "false").lower() == "true"

# --- Path whitelist ---
# Bu path'lerde eşleşen kurallar WARN'a düşer, fail etmez.
PATH_RULE_WHITELIST = [
    # datalib internal CB sistemi — koordinat macro'su ve storage temizliği normaldir
    ("data/datalib/function/api/cb/",         "MACRO_CHAIN"),
    ("data/datalib/function/api/cb/",         "DATA_REMOVE_ENGINE"),
    ("data/datalib/function/systems/cb/",     "MACRO_CHAIN"),
    ("data/datalib/function/systems/cb/",     "DATA_REMOVE_ENGINE"),
    # load sırasında storage sıfırlama normaldir
    ("data/dl_load/function/load/storages",   "DATA_REMOVE_ENGINE"),
]

def is_whitelisted(fpath: str, label: str) -> bool:
    for path_prefix, rule_label in PATH_RULE_WHITELIST:
        if path_prefix in fpath and rule_label == label:
            return True
    return False

PATTERNS = [
    # Privilege escalation
    ("OP_GRANT",             r'(?<!#)^\s*op\s+(@[ase]|@p|\$|\S+)',                     "CRITICAL", "Grants operator to players"),
    ("DEOP",                 r'(?<!#)\bdeop\s+(@[ase]|@p|\$)',                          "HIGH",     "Removes operator status"),
    ("EXECUTE_AS_ALL_OP",    r'(?<!#)execute\s+as\s+@a.*\bop\b',                        "CRITICAL", "op via execute as @a"),
    ("WHITELIST_ADD",        r'(?<!#)\bwhitelist\s+add\b',                              "HIGH",     "Modifies whitelist"),
    ("WHITELIST_OFF",        r'(?<!#)\bwhitelist\s+off\b',                              "HIGH",     "Disables whitelist entirely"),
    ("BAN",                  r'(?<!#)\bban\s+(?!-ip)\S+',                               "HIGH",     "Bans a player"),
    ("BAN_IP",               r'(?<!#)\bban-ip\s+\S+',                                   "HIGH",     "Bans an IP"),
    ("PARDON",               r'(?<!#)\bpardon\b',                                        "MEDIUM",   "Unbans a player"),

    # Server control
    ("STOP",                 r'(?<!#)^\s*stop\s*$',                                     "CRITICAL", "Stops the server"),
    ("SAVE_OFF",             r'(?<!#)\bsave-off\b',                                     "HIGH",     "Disables world saving"),

    # Lag abuse
    ("SCHEDULE_APPEND",      r'(?<!#)\bschedule\s+function\b.*\bappend\b',              "MEDIUM",   "Repeated schedule append (lag risk)"),

    # Storage poisoning
    ("DATA_REMOVE_ENGINE",   r'(?<!#)\bdata\s+remove\s+storage\s+datalib:engine\b',    "CRITICAL", "Removes engine storage"),

    # Suspicious URLs
    ("URL_HTTP",             r'(?<!#).+"url"\s*:\s*"http://',                           "HIGH",     "Unencrypted HTTP URL in click_event"),
    ("URL_SUSPICIOUS",       r'(?<!#).+"url"\s*:\s*"https?://(?!github\.com|runtoolkit\.github\.io|modrinth\.com|curseforge\.com|minecraft\.net|mojang\.com|discord\.gg|discord\.com|planetminecraft\.com)',
                                                                                         "MEDIUM",   "URL to non-whitelisted domain"),

    # Macro injection
    ("MACRO_CHAIN",          r'(?<!#)\$.*\$\(',                                          "HIGH",     "Nested macro expansion (injection risk)"),
    ("MACRO_STORAGE_INJECT", r'(?<!#)\$function\s+\$\(',                                "CRITICAL", "Macro-expanded function path (injection)"),

    # Attribution tampering
    ("RT_ORIGIN_REMOVE",     r'(?<!#)\bdata\s+remove\s+storage\s+datalib:engine\s+global\.rt_origin_verified\b',
                                                                                         "HIGH",     "Removes attribution verification flag"),
]

results = []
total_critical = total_high = total_medium = 0
total_whitelisted = 0

for fpath in mcf_files:
    try:
        with open(fpath, encoding="utf-8") as f:
            lines = f.readlines()
    except Exception as e:
        results.append({"file": fpath, "error": str(e)})
        continue

    file_hits = []
    for lineno, line in enumerate(lines, 1):
        stripped = line.strip()
        if stripped.startswith("#"):
            continue
        for label, pattern, severity, desc in PATTERNS:
            if re.search(pattern, stripped, re.IGNORECASE):
                whitelisted = is_whitelisted(fpath, label)
                file_hits.append({
                    "line": lineno, "label": label,
                    "severity": severity, "desc": desc,
                    "content": stripped[:120],
                    "whitelisted": whitelisted,
                })
                if whitelisted:
                    total_whitelisted += 1
                elif severity == "CRITICAL": total_critical += 1
                elif severity == "HIGH":     total_high += 1
                elif severity == "MEDIUM":   total_medium += 1

    if file_hits:
        results.append({"file": fpath, "hits": file_hits})

if not results:
    print("SCAN_PASSED")
    github_output = os.environ.get("GITHUB_OUTPUT")
    if github_output:
        with open(github_output, "a") as f:
            f.write("critical=0\nhigh=0\nmedium=0\n")
    sys.exit(0)

# --- Report ---
report_lines = [
    "## ⚠️ PR Security Scan — Issues Found",
    "",
    "| Severity | Count |",
    "|----------|-------|",
    f"| 🔴 CRITICAL | {total_critical} |",
    f"| 🟠 HIGH     | {total_high} |",
    f"| 🟡 MEDIUM   | {total_medium} |",
]

if total_whitelisted > 0:
    report_lines.append(f"| ⚪ WHITELISTED (info) | {total_whitelisted} |")

if PR_AUTHOR_IS_ADMIN:
    report_lines += [
        "",
        "> ℹ️ **Admin bypass active** — PR author is a repository admin. Scan findings are informational only; merge is not blocked.",
    ]

report_lines.append("")

for entry in results:
    if "error" in entry:
        report_lines.append(f"### ❌ `{entry['file']}` — read error: {entry['error']}")
        continue
    report_lines.append(f"### `{entry['file']}`")
    for hit in entry["hits"]:
        if hit["whitelisted"]:
            report_lines.append(f"- ⚪ **WHITELISTED** `{hit['label']}` (line {hit['line']}): {hit['desc']} *(internal path — expected)*")
        else:
            icon = {"CRITICAL": "🔴", "HIGH": "🟠", "MEDIUM": "🟡"}.get(hit["severity"], "⚪")
            report_lines.append(f"- {icon} **{hit['severity']}** `{hit['label']}` (line {hit['line']}): {hit['desc']}")
        report_lines.append(f"  ```")
        report_lines.append(f"  {hit['content']}")
        report_lines.append(f"  ```")
    report_lines.append("")

report_lines += [
    "> **This scan is automated.** MEDIUM findings may be false positives.",
    "> CRITICAL and HIGH findings must be reviewed before merge.",
    "> Whitelisted findings are expected patterns in internal engine paths.",
]

report = "\n".join(report_lines)

github_step_summary = os.environ.get("GITHUB_STEP_SUMMARY")
if github_step_summary:
    with open(github_step_summary, "a") as f:
        f.write(report + "\n")

with open("/tmp/scan_report.md", "w") as f:
    f.write(report)

github_output = os.environ.get("GITHUB_OUTPUT")
if github_output:
    with open(github_output, "a") as f:
        f.write(f"critical={total_critical}\nhigh={total_high}\nmedium={total_medium}\n")

# Admin bypass: hiçbir zaman fail etme
if PR_AUTHOR_IS_ADMIN:
    print("SCAN_WARNED (admin bypass)")
    sys.exit(0)

if total_critical > 0 or total_high > 0:
    print("SCAN_FAILED")
    sys.exit(1)

print("SCAN_WARNED")
sys.exit(0)