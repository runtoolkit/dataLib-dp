#!/usr/bin/env python3
"""
dataLib Fix Library
Detects and fixes common datapack errors found during GameTest.
"""

import re
from pathlib import Path
from typing import List, Tuple

def detect_failed_to_load_errors(log_content: str) -> List[str]:
    """Detect 'Failed to load' errors from Minecraft logs"""
    errors = re.findall(r'Failed to load ([^\n]+)', log_content)
    return errors

def detect_fail_messages(log_content: str) -> List[str]:
    """Detect messages starting with 'Fail:'"""
    fails = re.findall(r'^Fail:.*$', log_content, re.MULTILINE)
    return fails

def fix_common_syntax_issues(content: str) -> Tuple[str, int]:
    """Apply common fixes to mcfunction files"""
    original = content
    fixes = 0

    # Fix 1: Score holder spacing
    if re.search(r'[\w.-]+:\s+', content):
        content = re.sub(r'([\w.-]+):\s+', r'\1:*', content)
        fixes += 1

    # Fix 2: Remove trailing spaces in commands
    content = re.sub(r' +$', '', content, flags=re.MULTILINE)
    if content != original:
        fixes += 1

    return content, fixes

def run_fix_library(workdir: Path, log_content: str = "") -> int:
    """Main entry point for the fix library"""
    total_fixes = 0

    # Check for critical errors
    failed_loads = detect_failed_to_load_errors(log_content)
    fail_messages = detect_fail_messages(log_content)

    if failed_loads:
        print(f"[FixLibrary] Detected {len(failed_loads)} 'Failed to load' errors")
        for err in failed_loads:
            print(f"  - {err}")

    if fail_messages:
        print(f"[FixLibrary] Detected {len(fail_messages)} FAIL messages")
        for msg in fail_messages:
            print(f"  - {msg}")

    # Apply fixes to all mcfunction files
    for mcfile in workdir.rglob("*.mcfunction"):
        try:
            content = mcfile.read_text(encoding="utf-8")
            new_content, fixes = fix_common_syntax_issues(content)
            if fixes > 0:
                mcfile.write_text(new_content, encoding="utf-8")
                total_fixes += fixes
        except Exception:
            continue

    if total_fixes > 0:
        print(f"[FixLibrary] Applied {total_fixes} fixes")
    else:
        print("[FixLibrary] No fixes needed")

    return total_fixes