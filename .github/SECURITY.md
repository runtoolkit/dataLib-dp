# Security Policy

## Supported Versions

This project is a Minecraft Java Edition datapack.  
Security updates are only provided for the following versions:

| Version | Supported |
| ------- | --------- |
| 5.0.x   | :white_check_mark: |
| 3.0.x   | :x: |
| < 3.0   | :x: |

### Notes

- Only **critical vulnerabilities** are patched.
- No backports for unsupported versions.
- Minecraft snapshot versions are not officially supported.
- Performance issues are not considered security issues unless they cause server crashes or denial-of-service behavior.

---

## Reporting a Vulnerability

If you discover a security vulnerability, **do NOT open a public issue.**

### What qualifies as a vulnerability?

Examples include:

- Permission bypass via `execute`
- Scoreboard manipulation exploits
- NBT injection
- Storage tampering
- Unauthorized admin function execution
- Infinite loop / server crash triggers
- Selector abuse (`@a`, `@e`) causing unintended execution

---

## How to Report

Report privately using one of the following methods:

1. GitHub Security Advisory (preferred)
2. Direct contact with the maintainer

---

## Required Report Information

Please include:

- Affected datapack version
- Minecraft version
- Technical explanation of the exploit
- Steps to reproduce
- Expected behavior
- Actual behavior
- Proof-of-concept (minimal test world or commands, if possible)

Incomplete reports may not be processed.

---

## Response Policy

- Initial response: within 72 hours
- Status update: within 7 days
- Target fix time for critical issues: 14 days

If the vulnerability is confirmed:

- A patched version will be released
- The advisory will be published after the fix
- The reporter may be credited (optional)

If declined:

- A technical explanation will be provided
- No further action will be taken

---

## Scope

This security policy applies only to the official release versions of this datapack.

Modifications, forks, unofficial builds, or altered distributions are not covered.
