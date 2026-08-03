#!/usr/bin/env python3
import os
import sys
import re
import json
import shutil
import zipfile
import time
from datetime import datetime
from pathlib import Path
from collections import defaultdict

# ==============================================================================
# Terminal Text Hacks & Color Configuration (ANSI Color Codes + Stylizers)
# ==============================================================================
try:
    import colorama
    colorama.init(autoreset=True)
except ImportError:
    pass

class Logger:
    # ANSI Formatting Styles
    RESET = "\033[0m"
    BOLD = "\033[1m"
    DIM = "\033[2m"
    ITALIC = "\033[3m"
    UNDERLINE = "\033[4m"
    BLINK = "\033[5m"
    REVERSE = "\033[7m"

    # Standard Colors
    HEADER = "\033[95m"
    INFO = "\033[94m"
    SUCCESS = "\033[92m"
    WARNING = "\033[93m"
    ERROR = "\033[91m"
    MUTED = "\033[90m"
    CYAN = "\033[96m"

    @classmethod
    def _timestamp(cls) -> str:
        return f"{cls.MUTED}[{datetime.now().strftime('%H:%M:%S')}]{cls.RESET}"

    @classmethod
    def banner(cls, text: str):
        width = 65
        print(f"\n{cls.CYAN}╔{'═' * width}╗{cls.RESET}")
        print(f"{cls.CYAN}║{cls.BOLD}{text.center(width)}{cls.RESET}{cls.CYAN}║{cls.RESET}")
        print(f"{cls.CYAN}╚{'═' * width}╝{cls.RESET}\n")

    @classmethod
    def step(cls, step_num, name: str):
        timestamp = cls._timestamp()
        divider = f"{cls.MUTED}{'─' * 55}{cls.RESET}"
        label = f"{step_num:02d}" if isinstance(step_num, int) else str(step_num)
        print(f"\n{divider}")
        print(f"{timestamp} {cls.BOLD}{cls.HEADER}🚀 STEP {label}:{cls.RESET} {cls.BOLD}{name}{cls.RESET}")
        print(f"{divider}")

    @classmethod
    def info(cls, msg: str):
        print(f"  {cls._timestamp()} {cls.INFO}ℹ️  [INFO]{cls.RESET} {msg}")

    @classmethod
    def success(cls, msg: str):
        print(f"  {cls._timestamp()} {cls.SUCCESS}✔  [OK]{cls.RESET} {msg}")

    @classmethod
    def warn(cls, msg: str):
        print(f"  {cls._timestamp()} {cls.WARNING}⚠️  [WARN]{cls.RESET} {msg}")

    @classmethod
    def error(cls, msg: str):
        print(f"  {cls._timestamp()} {cls.ERROR}✖  [ERROR]{cls.RESET} {msg}")

    @classmethod
    def debug(cls, msg: str):
        print(f"  {cls._timestamp()} {cls.MUTED}🔍 [DEBUG]{cls.RESET} {msg}")

    @classmethod
    def progress_bar(cls, iteration: int, total: int, prefix='Progress', suffix='Complete', length=30):
        """Terminal Text Hack: Smooth Dynamic ASCII Progress Bar"""
        percent = f"{100 * (iteration / float(total)):.1f}"
        filled_length = int(length * iteration // total)
        bar = '█' * filled_length + '░' * (length - filled_length)
        sys.stdout.write(f"\r  {cls._timestamp()} {cls.CYAN}⏳ {prefix}{cls.RESET} |{cls.SUCCESS}{bar}{cls.RESET}| {percent}% {cls.DIM}{suffix}{cls.RESET}")
        sys.stdout.flush()
        if iteration == total:
            sys.stdout.write("\n")

    @classmethod
    def spinner(cls, message: str, duration: float = 0.6):
        """Terminal Text Hack: Inline Braille Animation Spinner"""
        frames = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
        end_time = time.time() + duration
        idx = 0
        while time.time() < end_time:
            sys.stdout.write(f"\r  {cls._timestamp()} {cls.CYAN}{frames[idx % len(frames)]}{cls.RESET} {message}...")
            sys.stdout.flush()
            time.sleep(0.08)
            idx += 1
        sys.stdout.write(f"\r{' ' * (len(message) + 25)}\r")


# ==============================================================================
# Directory Setup & Constants
# ==============================================================================
WORKSPACE = Path(os.getcwd()).resolve()
TMP_BACKUP = Path("/tmp/backup/dataLib-dp-pristine")
TMP_WORK = Path("/tmp/work/dataLib-dp")
TMP_ANALYSIS = Path("/tmp/analysis")
DIST_DIR = TMP_WORK / "dist"

SRC_ROOT = TMP_WORK / "datapacks/dataLib/data/datalib/function"
DST_BASE = TMP_WORK / "packs/modules"

# Single source of truth for which source subtrees are scanned for
# per-module discovery. Previously this list only lived inside
# step_8_build_module_map(); every other step relied on module_map.json
# already reflecting it, which is fragile if scan_roots ever changes.
# Now every step references this same constant directly.
SCAN_ROOTS = ["systems", "input", "api", "player", "world", "systems",
              "core/cooldown", "core/lib", "core/state", "core/queue"]


# ==============================================================================
# Migration Steps
# ==============================================================================

def step_1_backup():
    Logger.step(1, "Backup Pristine Checkout")
    Logger.spinner("Creating full backup of original repo")
    if TMP_BACKUP.exists():
        shutil.rmtree(TMP_BACKUP)
    TMP_BACKUP.parent.mkdir(parents=True, exist_ok=True)
    
    shutil.copytree(WORKSPACE, TMP_BACKUP)
    Logger.success(f"Backup created: {Logger.UNDERLINE}{TMP_BACKUP}{Logger.RESET}")


def step_2_prepare_work_dir():
    Logger.step(2, "Prepare Isolated Work Directory")
    Logger.spinner("Initializing isolated workspace")
    if TMP_WORK.exists():
        shutil.rmtree(TMP_WORK)
    TMP_WORK.parent.mkdir(parents=True, exist_ok=True)
    TMP_ANALYSIS.mkdir(parents=True, exist_ok=True)

    shutil.copytree(WORKSPACE, TMP_WORK)
    Logger.success(f"Working copy ready: {Logger.UNDERLINE}{TMP_WORK}{Logger.RESET}")


def step_3_verify_layout():
    Logger.step(3, "Verify Expected Source Layout")
    expected = TMP_WORK / "datapacks/dataLib/data/datalib/function"
    if not expected.is_dir():
        Logger.error(f"Expected source path not found: {expected}")
        Logger.info("This script expects layout: datapacks/dataLib/data/datalib/...")
        sys.exit(1)
    Logger.success(f"Layout OK: {expected.relative_to(TMP_WORK)} exists")


def step_4_move_fabric_files():
    Logger.step(4, "Move Fabric/Mod/Script Files into 'other/'")
    other_dir = TMP_WORK / "other"
    other_dir.mkdir(exist_ok=True)

    targets = [
        "build.gradle", "settings.gradle", "gradle.properties", "gradle", 
        "gradlew", "gradlew.bat", "src", "build_jmc.py", "jmc_config.json", 
        "main.jmc", "spyglass.json", "commit.sh", "show_dependencies.sh", "NOTICE.sh"
    ]

    moved_count = 0
    for item in targets:
        src = TMP_WORK / item
        if src.exists():
            shutil.move(str(src), str(other_dir / item))
            Logger.debug(f"Moved: {item} -> other/")
            moved_count += 1
        else:
            Logger.warn(f"Skipped (not found): {item}")

    Logger.info(f"Relocated {moved_count} project management / source files.")


def step_5_clean_deps():
    Logger.step(5, "Remove Duplicate Dependencies File")
    dep_file = TMP_WORK / ".dependencies.json"
    if dep_file.exists():
        dep_file.unlink()
        Logger.success(".dependencies.json removed.")
    else:
        Logger.debug("No .dependencies.json found, skipping clean.")


def step_6_build_function_graph():
    Logger.step(6, "Build Function Dependency Graph")
    root = TMP_WORK / "datapacks/dataLib/data/datalib/function"
    
    files = list(root.glob("**/*.mcfunction"))
    if not files:
        Logger.error(f"No .mcfunction files found under {root}")
        sys.exit(1)

    def to_id(path: Path):
        rel = path.relative_to(root).with_suffix("")
        return "datalib:" + str(rel).replace(os.sep, "/")

    all_ids = set(to_id(f) for f in files)
    ref_pattern = re.compile(r'datalib:([a-z0-9_/.\-]+)')
    other_ns_pattern = re.compile(r'\b(dl_load|stringlib|player_action|load):([a-z0-9_/.\-]+)')

    edges = defaultdict(set)
    external_refs = defaultdict(set)

    for i, f in enumerate(files, 1):
        fid = to_id(f)
        content = f.read_text(encoding="utf-8", errors="replace")
        
        for m in ref_pattern.finditer(content):
            edges[fid].add("datalib:" + m.group(1))
        for m in other_ns_pattern.finditer(content):
            external_refs[fid].add(f"{m.group(1)}:{m.group(2)}")
        
        if i % 10 == 0 or i == len(files):
            Logger.progress_bar(i, len(files), prefix="Scanning functions")

    (TMP_ANALYSIS / "edges.json").write_text(json.dumps({k: sorted(v) for k, v in edges.items()}, indent=2))
    (TMP_ANALYSIS / "external_refs.json").write_text(json.dumps({k: sorted(v) for k, v in external_refs.items() if v}, indent=2))
    (TMP_ANALYSIS / "all_ids.json").write_text(json.dumps(sorted(all_ids), indent=2))

    Logger.info(f"Total .mcfunction files scanned: {len(files)}")
    Logger.info(f"Files referencing external namespaces: {len([k for k, v in external_refs.items() if v])}")


def step_7_prepare_core_skeleton():
    Logger.step(7, "Prepare Core Module Skeleton")
    base = TMP_WORK / "packs/modules/datalib-core/data"
    
    subdirs = [
        "datalib_core/function/internal", "datalib_core/function/load",
        "datalib_core/function/tick", "datalib_core/function/gate",
        "minecraft/tags/function/load", "minecraft/tags/function/tick"
    ]
    for path in subdirs:
        (base / path).mkdir(parents=True, exist_ok=True)

    Logger.success("Core skeleton structure generated.")


def step_8_build_module_map():
    Logger.step(8, "Build Module -> Source Path Mapping")
    src = TMP_WORK / "datapacks/dataLib/data/datalib/function"
    scan_roots = ["systems", "api","core/cooldown","core/lib","core/state","core/queue"]

    discovered = {}
    underscore_dirs = []  # (scan_root, entry_name) pairs -- resolved in step_8b
    for r in scan_roots:
        r_full = src / r
        if not r_full.is_dir():
            continue
        for entry in sorted(os.listdir(r_full)):
            if not (r_full / entry).is_dir():
                continue
            if entry.startswith("_"):
                underscore_dirs.append((r, entry))
                continue
            discovered.setdefault(entry, []).append(f"{r}/{entry}")

    # `player`, `world`, `events`, `input` are each their own standalone
    # module as a whole -- unlike scan_roots (which turns each subdirectory
    # into a separate module), everything directly under these four roots
    # (loose .mcfunction files included) belongs to one module named after
    # the root itself.
    whole_root_modules = ["player", "world", "events", "input"]
    for root_name in whole_root_modules:
        root_full = src / root_name
        if root_full.is_dir():
            discovered.setdefault(root_name, []).append(root_name)

    covered = set(path for paths in discovered.values() for path in paths)
    remaining_top = set()

    for entry in os.listdir(src):
        full = src / entry
        if not full.is_dir():
            continue
        if entry == "systems":
            for sub in os.listdir(full):
                key = f"systems/{sub}"
                if key not in covered: remaining_top.add(key)
        elif entry == "core":
            for sub in os.listdir(full):
                if sub == "internal":
                    for sub2 in os.listdir(full / "internal"):
                        if sub2 == "systems":
                            for sub3 in os.listdir(full / "internal/systems"):
                                key = f"core/internal/systems/{sub3}"
                                if key not in covered: remaining_top.add(key)
                        else:
                            remaining_top.add(f"core/internal/{sub2}")
                else:
                    remaining_top.add(f"core/{sub}")
        elif entry == "api":
            for sub in os.listdir(full):
                key = f"api/{sub}"
                if key not in covered: remaining_top.add(key)
        elif entry in whole_root_modules:
            pass  # already captured as a whole-root module above
        else:
            remaining_top.add(entry)

    (TMP_ANALYSIS / "module_map.json").write_text(json.dumps({
        "modules": discovered,
        "core_remaining": sorted(remaining_top),
        "underscore_dirs": underscore_dirs,
    }, indent=2, ensure_ascii=False))

    Logger.info(f"Auto-detected modules ({len(discovered)}): {Logger.CYAN}{sorted(discovered.keys())}{Logger.RESET}")
    Logger.success("module_map.json successfully written.")


def step_8b_resolve_underscore_dirs():
    # Underscore-prefixed dirs (e.g. input/_private) are internal-helper
    # trees, not standalone modules -- but they must never be silently
    # dropped. Each one is folded into exactly one real module, with an
    # explicit, logged decision for every case:
    #   1 sibling module in the same scan root -> fold into it
    #   0 or >1 siblings (ambiguous)           -> fold into "core"
    # Either way the source path is guaranteed to end up in `discovered`.
    Logger.step("8b", "Resolve Underscore-Prefixed Internal Dirs")
    src = TMP_WORK / "datapacks/dataLib/data/datalib/function"
    map_path = TMP_ANALYSIS / "module_map.json"
    mm = json.loads(map_path.read_text())
    discovered = mm["modules"]
    underscore_dirs = mm.get("underscore_dirs", [])

    if not underscore_dirs:
        Logger.info("No underscore-prefixed directories found.")
        return

    for r, entry in underscore_dirs:
        r_full = src / r
        siblings = [
            s for s in os.listdir(r_full)
            if s != entry and not s.startswith("_") and (r_full / s).is_dir()
        ]
        source_path = f"{r}/{entry}"
        if len(siblings) == 1:
            target = siblings[0]
            reason = f"sole sibling module '{target}' under {r}/"
        else:
            target = "core"
            reason = f"ambiguous ({len(siblings)} siblings under {r}/) -> defaulting to core"
        discovered.setdefault(target, []).append(source_path)
        Logger.info(f"{source_path} -> {target} ({reason})")

    mm["modules"] = discovered
    map_path.write_text(json.dumps(mm, indent=2, ensure_ascii=False))
    Logger.success(f"Resolved {len(underscore_dirs)} underscore-prefixed dir(s); none dropped.")


def step_8c_relocate_root_dirs_to_api():
    # `player`, `world`, `events`, and `input` are standalone modules in
    # their own right and must NOT be folded into api/ -- they're scanned
    # directly as their own scan roots in step_8 instead.
    #
    # Any *other* root-level dir that isn't a recognized scan root (i.e.
    # not systems/api/core/config/debug and not one of the four standalone
    # roots above) gets folded into api/ before module discovery, so it
    # still becomes a real module instead of silently sitting outside
    # every scan root. This runs before step_8's discovery scan, so
    # step_9's existing classify()/token_pattern remap naturally picks up
    # the new on-disk location -- no separate call-rewriting pass needed.
    Logger.step("8c", "Relocate Unrecognized Root-Level Dirs Into api/")
    src = TMP_WORK / "datapacks/dataLib/data/datalib/function"
    api_dir = src / "api"
    standalone_roots = {"player", "world", "events", "input"}
    reserved = {"systems", "api", "core", "config", "debug"} | standalone_roots

    root_dirs = sorted(
        entry for entry in os.listdir(src)
        if (src / entry).is_dir() and entry not in reserved
    )

    if not root_dirs:
        Logger.info("No unrecognized root-level directories found; player/world/events/input kept as their own standalone modules.")
        return

    api_dir.mkdir(parents=True, exist_ok=True)
    total_moved = []
    for root_name in root_dirs:
        root_dir = src / root_name
        moved = []
        for entry in sorted(os.listdir(root_dir)):
            src_entry = root_dir / entry
            dst_entry = api_dir / entry
            if dst_entry.exists():
                Logger.warn(f"api/{entry} already exists -- merging contents from {root_name}/{entry} instead of overwriting.")
                if src_entry.is_dir():
                    for sub_dirpath, _, sub_files in os.walk(src_entry):
                        rel = Path(sub_dirpath).relative_to(src_entry)
                        target_dir = dst_entry / rel
                        target_dir.mkdir(parents=True, exist_ok=True)
                        for f in sub_files:
                            shutil.move(str(Path(sub_dirpath) / f), str(target_dir / f))
                    shutil.rmtree(src_entry)
                else:
                    shutil.move(str(src_entry), str(dst_entry))
            else:
                shutil.move(str(src_entry), str(dst_entry))
            moved.append(entry)

        root_dir.rmdir()
        total_moved.extend(moved)
        Logger.info(f"Relocated {len(moved)} entr{'y' if len(moved)==1 else 'ies'} from {root_name}/ to api/: {moved}")

    Logger.success(f"{len(root_dirs)} unrecognized root-level dir(s) absorbed into api/; player/world/events/input kept standalone.")


def step_9_migrate_functions():
    Logger.step(9, "Migrate Function Files and Remap Namespaces")
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    modules = mmap["modules"]

    prefix_to_module = {p: mod for mod, paths in modules.items() for p in paths}

    def classify(rel_path):
        best = None
        for prefix in prefix_to_module:
            if rel_path == prefix or rel_path.startswith(prefix + "/"):
                if best is None or len(prefix) > len(best):
                    best = prefix
        return prefix_to_module.get(best, "core") if best else "core"

    def new_namespace_for(rel_noext):
        mod = classify(rel_noext)
        return f"datalib_{mod}" if mod != "core" else "datalib_core"

    id_table = {}
    all_files = []
    
    for dirpath, _, filenames in os.walk(SRC_ROOT):
        for fn in filenames:
            if not fn.endswith(".mcfunction"):
                continue
            old_abs = Path(dirpath) / fn
            rel = old_abs.relative_to(SRC_ROOT)
            rel_noext = str(rel.with_suffix("")).replace(os.sep, "/")
            ns = new_namespace_for(rel_noext)
            id_table[rel_noext] = f"{ns}:{rel_noext}"
            all_files.append((old_abs, rel_noext, ns))

    shared_storages = {"engine", "input", "output"}
    token_pattern = re.compile(r'datalib:([a-zA-Z0-9_/.\-]+)')

    def remap_token(match):
        path = match.group(1)
        trail = ""
        core_path = path
        while core_path and core_path[-1] in ".,":
            trail = core_path[-1] + trail
            core_path = core_path[:-1]
        if core_path in shared_storages:
            return f"datalib_core:{core_path}{trail}"
        if core_path in id_table:
            return id_table[core_path] + trail
        ns = new_namespace_for(core_path)
        return f"{ns}:{core_path}{trail}"

    total_files = len(all_files)
    for i, (old_abs, rel_noext, ns) in enumerate(all_files, 1):
        mod_key = ns.replace("datalib_", "")
        if mod_key == "core":
            dst_dir = DST_BASE / "datalib-core/data/datalib_core/function"
        else:
            dst_dir = DST_BASE / f"datalib-{mod_key}-module/data/{ns}/function"
        
        dst_path = dst_dir / f"{rel_noext}.mcfunction"
        dst_path.parent.mkdir(parents=True, exist_ok=True)

        content = old_abs.read_text(encoding="utf-8", errors="replace")
        new_content = token_pattern.sub(remap_token, content)
        dst_path.write_text(new_content, encoding="utf-8")

        if i % 15 == 0 or i == total_files:
            Logger.progress_bar(i, total_files, prefix="Migrating functions")

    (TMP_ANALYSIS / "id_table.json").write_text(json.dumps(id_table, indent=2))
    Logger.success(f"Files moved & namespaces remapped: {total_files}")


def step_10_migrate_dlload():
    Logger.step(10, "Migrate dl_load into datalib_core:load_gate")
    dlload_stage = Path("/tmp/dlload_stage")
    if dlload_stage.exists(): shutil.rmtree(dlload_stage)
    
    src_dlload = TMP_WORK / "datapacks/dataLib/data/dl_load/function"
    if src_dlload.exists():
        shutil.copytree(src_dlload, dlload_stage / "function")

    dst = DST_BASE / "datalib-core/data/datalib_core/function/load_gate"
    dst.mkdir(parents=True, exist_ok=True)

    token_pattern = re.compile(r'\bdl_load:([a-zA-Z0-9_/.\-]+)')

    def remap(m):
        path = m.group(1).rstrip(".,")
        return f"datalib_core:load_gate/{path}"

    count = 0
    stage_func = dlload_stage / "function"
    if stage_func.exists():
        for dirpath, _, files in os.walk(stage_func):
            for fn in files:
                if not fn.endswith(".mcfunction"): continue
                old_abs = Path(dirpath) / fn
                rel = old_abs.relative_to(stage_func)
                dst_path = dst / rel
                dst_path.parent.mkdir(parents=True, exist_ok=True)

                content = old_abs.read_text(encoding="utf-8", errors="replace")
                new_content = token_pattern.sub(remap, content)
                new_content = re.sub(r'\bdatalib:(engine|input|output)\b', r'datalib_core:\1', new_content)
                dst_path.write_text(new_content, encoding="utf-8")
                count += 1

    Logger.success(f"Migrated dl_load files: {count}")


def step_11_create_tags_and_ticks():
    Logger.step(11, "Create Load/Tick Function Tags")
    core_dir = DST_BASE / "datalib-core"
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    modules = sorted(mmap["modules"].keys())
    module_load_tags = [f"dl_{m}.load:main" for m in modules]

    def write_json(rel, obj):
        p = core_dir / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(obj, indent=2) + "\n", encoding="utf-8")

    def write_text(rel, body):
        p = core_dir / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(body, encoding="utf-8")

    def merge_json_values(rel, extra_values):
        p = core_dir / rel
        existing = []
        if p.is_file():
            try:
                existing = json.loads(p.read_text()).get("values", [])
            except Exception:
                existing = []
        seen = set(v if isinstance(v, str) else json.dumps(v, sort_keys=True) for v in existing)
        for v in extra_values:
            k = v if isinstance(v, str) else json.dumps(v, sort_keys=True)
            if k not in seen:
                existing.append(v)
                seen.add(k)
        write_json(rel, {"values": existing})

    write_text(
        "data/load/function/_private/load.mcfunction",
        "# Reset scoreboards for current load.\nscoreboard objectives add load.status dummy\nscoreboard players reset * load.status\n"
    )
    write_text("data/load/function/_private/init.mcfunction", "# load:_private/init\n")
    
    write_json("data/load/tags/function/_private/load.json", {
        "values": ["#load:_private/init", {"id": "#load:pre_load", "required": False}, {"id": "#load:load", "required": False}, {"id": "#load:post_load", "required": False}]
    })
    write_json("data/load/tags/function/_private/init.json", {"values": ["load:_private/init"]})
    write_json("data/load/tags/function/load.json", {"values": ["stringlib:zprivate/load", "datalib_core:init", "#player_action:load","datalib_core:load_gate/main"]})
    write_json("data/load/tags/function/pre_load.json", {"values": []})
    write_json("data/load/tags/function/post_load.json", {"values": module_load_tags})
    write_json("data/minecraft/tags/function/load.json", {"values": ["datalib_core:init"]})
    write_json("data/minecraft/tags/function/tick.json", {"values": ["datalib_core:tick"]})

    write_text(
        "data/datalib_core/function/init.mcfunction",
        "#> Runs on datapack loading\nexecute if data storage datalib_core:engine {global:{loaded:1b}} run return 0\nscoreboard players set #StringLib.ShowLoadMessage StringLib 0\nfunction #load:_private/load\n"
    )
    write_text(
        "data/datalib_core/function/tick.mcfunction",
        "# datalib_core:tick\nfunction datalib_core:core/tick\nfunction #datalib_core:loop\nfunction #datalib_core:events/on_tick\n"
    )

    default_loop = [
        "datalib_core:input/writable_book",
        "datalib_core:input/command_block_minecart",
        "datalib_core:core/internal/api/cmd/freeze/tick",
        "datalib_core:input/_private/cbm_align_tp",
    ]
    merge_json_values("data/datalib_core/tags/function/loop.json", default_loop)

    discovered_ticks = []
    for m in modules:
        ns = f"datalib_{m}"
        pack = f"datalib-{m}-module"
        fn_root = DST_BASE / pack / "data" / ns / "function"
        if not fn_root.is_dir(): continue
        
        for dirpath, _, files in os.walk(fn_root):
            for fn in files:
                if not fn.endswith(".mcfunction"): continue
                stem = fn[:-len(".mcfunction")]
                if stem == "tick" or stem.startswith("tick_") or stem.endswith("_tick"):
                    rel = Path(dirpath, fn).relative_to(fn_root).with_suffix("")
                    rel_noext = str(rel).replace(os.sep, "/")
                    discovered_ticks.append(f"{ns}:{rel_noext}")

    discovered_ticks = sorted(set(discovered_ticks))
    merge_json_values("data/datalib_core/tags/function/events/on_tick.json", discovered_ticks)

    on_load = "data/datalib_core/tags/function/events/on_load.json"
    if not (core_dir / on_load).is_file():
        write_json(on_load, {"values": []})

    write_text("data/datalib.main/function/empty.mcfunction", "#> datalib.main:empty\n")
    Logger.success("Load & Tick tags correctly configured.")


def step_12_migrate_extras():
    Logger.step(12, "Migrate Advancements, Loot Tables, Predicates, Item Modifiers & Dialogs")
    src_root = TMP_WORK / "datapacks/dataLib/data/datalib"
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    modules = mmap["modules"]
    id_table = json.loads((TMP_ANALYSIS / "id_table.json").read_text())

    prefix_to_module = {p: mod for mod, paths in modules.items() for p in paths}

    def classify(rel_path):
        best = None
        for prefix in prefix_to_module:
            if rel_path == prefix or rel_path.startswith(prefix + "/"):
                if best is None or len(prefix) > len(best):
                    best = prefix
        return prefix_to_module.get(best, "core") if best else "core"

    categories = ["advancement", "loot_table", "predicate", "item_modifier", "dialog"]
    shared_storages = {"engine", "input", "output"}
    token_pattern = re.compile(r'datalib:([a-zA-Z0-9_/.\-]+)')

    def remap_token_in_text(text):
        def remap(m):
            path = m.group(1)
            trail = ""
            core_path = path
            while core_path and core_path[-1] in ".,":
                trail = core_path[-1] + trail
                core_path = core_path[:-1]
            if core_path in shared_storages:
                return f"datalib_core:{core_path}{trail}"
            if core_path in id_table:
                return id_table[core_path] + trail
            ns = classify(core_path)
            ns_name = f"datalib_{ns}" if ns != "core" else "datalib_core"
            return f"{ns_name}:{core_path}{trail}"
        return token_pattern.sub(remap, text)

    moved = 0
    for cat in categories:
        cat_src = src_root / cat
        if not cat_src.is_dir(): continue
        for dirpath, _, files in os.walk(cat_src):
            for fn in files:
                old_abs = Path(dirpath) / fn
                rel = old_abs.relative_to(cat_src)
                rel_noext = os.path.join(cat, rel)
                rel_noext_no_json = str(rel_noext)[:-len(".json")] if str(rel_noext).endswith(".json") else str(rel_noext)
                
                content = old_abs.read_text(encoding="utf-8", errors="replace")
                m = token_pattern.search(content)
                target_mod = "core"
                if m:
                    candidate = m.group(1).rstrip(".,")
                    if candidate not in shared_storages:
                        target_mod = classify(candidate)
                if not m:
                    target_mod = classify(rel_noext_no_json)

                ns = f"datalib_{target_mod}" if target_mod != "core" else "datalib_core"
                dst_dir = DST_BASE / ("datalib-core/data/datalib_core" if target_mod == "core" else f"datalib-{target_mod}-module/data/{ns}") / cat
                
                dst_path = dst_dir / rel
                dst_path.parent.mkdir(parents=True, exist_ok=True)
                dst_path.write_text(remap_token_in_text(content), encoding="utf-8")
                moved += 1

    Logger.success(f"Extra data assets migrated: {moved}")


def step_13_migrate_tags():
    Logger.step(13, "Migrate Function Tags")
    src = TMP_WORK / "datapacks/dataLib/data/datalib/tags"
    dst = DST_BASE / "datalib-core/data/datalib_core/tags"

    id_table = json.loads((TMP_ANALYSIS / "id_table.json").read_text())
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    modules = mmap["modules"]
    prefix_to_module = {p: mod for mod, paths in modules.items() for p in paths}

    def classify(rel_path):
        best = None
        for prefix in prefix_to_module:
            if rel_path == prefix or rel_path.startswith(prefix + "/"):
                if best is None or len(prefix) > len(best):
                    best = prefix
        return prefix_to_module.get(best, "core") if best else "core"

    shared_storages = {"engine", "input", "output"}
    token_pattern = re.compile(r'datalib:([a-zA-Z0-9_/.\-]+)')

    def remap(text):
        def sub(m):
            path = m.group(1)
            trail = ""
            core_path = path
            while core_path and core_path[-1] in ".,":
                trail = core_path[-1] + trail
                core_path = core_path[:-1]
            if core_path in shared_storages:
                return f"datalib_core:{core_path}{trail}"
            if core_path in id_table:
                return id_table[core_path] + trail
            ns = classify(core_path)
            ns_name = f"datalib_{ns}" if ns != "core" else "datalib_core"
            return f"{ns_name}:{core_path}{trail}"
        return token_pattern.sub(sub, text)

    moved = 0
    if src.is_dir():
        for dirpath, _, files in os.walk(src):
            for fn in files:
                old_abs = Path(dirpath) / fn
                rel = old_abs.relative_to(src)
                dst_path = dst / rel
                dst_path.parent.mkdir(parents=True, exist_ok=True)
                content = old_abs.read_text(encoding="utf-8", errors="replace")
                dst_path.write_text(remap(content), encoding="utf-8")
                moved += 1

    Logger.success(f"Tag files migrated: {moved}")


def step_14_cleanup_old_module_dirs():
    Logger.step(14, "Remove Old Module Source Directories")
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    modules = mmap["modules"]

    removed, skipped = [], []
    for mod, paths in modules.items():
        for rel_path in paths:
            full = SRC_ROOT / rel_path
            if full.is_dir():
                shutil.rmtree(full)
                removed.append(rel_path)
            else:
                skipped.append(rel_path)

    for parent in ["systems", "core/internal/systems", "api"]:
        full = SRC_ROOT / parent
        if full.is_dir() and not os.listdir(full):
            full.rmdir()

    Logger.info(f"Removed {len(removed)} old module source directories.")
    for r in sorted(removed):
        Logger.debug(f" - {r}")


def step_15_post_fixes():
    Logger.step(15, "Post-Migration Cleanups & Metadata Generation")
    
    # 1. Clean duplicate load.mcfunction
    dup = DST_BASE / "datalib-core/data/datalib_core/function/load.mcfunction"
    if dup.is_file():
        dup.unlink()
        Logger.debug("Duplicate load.mcfunction removed.")

    # 2. Fix sound namespace
    sound_target = DST_BASE / "datalib-core/data/datalib_core/function"
    if sound_target.is_dir():
        for p in sound_target.glob("**/*.mcfunction"):
            txt = p.read_text(encoding="utf-8", errors="replace")
            if "playsound datalib_core:" in txt:
                p.write_text(txt.replace("playsound datalib_core:", "playsound datalib:"), encoding="utf-8")

    # 3. Create load skeleton
    mmap = json.loads((TMP_ANALYSIS / "module_map.json").read_text())
    module_list = sorted(mmap["modules"].keys())
    for m in module_list:
        (DST_BASE / f"datalib-{m}-module/data/datalib_{m}/function/load").mkdir(parents=True, exist_ok=True)
        (DST_BASE / f"datalib-{m}-module/data/dl_{m}.load/function").mkdir(parents=True, exist_ok=True)

    # 4. Discover each module's actual scoreboard objectives & storage
    #    roots by scanning its migrated .mcfunction files, then GENERATE
    #    real init.mcfunction / cleanup.mcfunction files from that data.
    #    Previously init/cleanup were either hardcoded to a wrong module
    #    set or left as bare comments -- neither approach reflected what
    #    the module actually touches, and both could leave init/cleanup
    #    empty or referencing files that don't exist.
    objective_def_pattern = re.compile(r'\bscoreboard\s+objectives\s+add\s+(\S+)\s+\S+')
    # `scoreboard players <set|add|remove|get|enable|operation> <targets> <objective> ...`
    # -- the objective is the token right after the target selector.
    objective_use_pattern = re.compile(
        r'\bscoreboard\s+players\s+(?:set|add|remove|get|enable|operation|reset)\s+\S+\s+(\S+)'
    )

    def _clean_objective(raw_obj):
        # Reject macro placeholders (e.g. $(objective), $(pb_obj)) -- these
        # are resolved at runtime per-call and aren't a fixed objective
        # name this module can pre-declare.
        if not raw_obj or raw_obj.startswith("$("):
            return None
        return raw_obj

    # Captures the storage id as a single colon-joined token (ns:root) and,
    # if present, the following NBT key as a separate token -- this matches
    # real syntax: `data modify storage <ns:root> <nbt_key> set value ...`.
    # The storage id itself is never split on the colon; `<ns:root>` and
    # `<key>` are two distinct command arguments.
    storage_pattern = re.compile(r'\bstorage\s+(datalib_[a-z0-9_]*:[a-zA-Z0-9_]+)(?:\s+([a-zA-Z0-9_.\[\]]+))?')

    def _clean_key(raw_key):
        # Reject anything that isn't a genuine NBT path segment (e.g. an
        # inline `{}`/`{...}` literal that the regex's generic tail
        # accidentally swept up).
        if not raw_key or raw_key in ("{}",) or raw_key.startswith("{"):
            return None
        return raw_key

    def scan_module_usage(m, ns):
        mod_root = DST_BASE / f"datalib-{m}-module/data/{ns}/function"
        objectives = set()
        storages = set()  # set of (storage_id, nbt_key_or_None) pairs
        if mod_root.is_dir():
            for p in mod_root.glob("**/*.mcfunction"):
                txt = p.read_text(encoding="utf-8", errors="replace")
                for line in txt.splitlines():
                    stripped = line.strip()
                    if stripped.startswith("#"):
                        continue
                    for om in objective_def_pattern.finditer(line):
                        obj = _clean_objective(om.group(1))
                        if obj:
                            objectives.add(obj)
                    for om in objective_use_pattern.finditer(line):
                        obj = _clean_objective(om.group(1))
                        if obj:
                            objectives.add(obj)
                    for sm in storage_pattern.finditer(line):
                        storages.add((sm.group(1), _clean_key(sm.group(2))))
        return sorted(objectives), sorted(storages, key=lambda t: (t[0], t[1] or ""))

    for m in module_list:
        ns = f"datalib_{m}"
        dir_path = DST_BASE / f"datalib-{m}-module/data/dl_{m}.load/function"
        objectives, storage_pairs = scan_module_usage(m, ns)

        # -- init.mcfunction: (re)create every objective/storage this
        #    module actually references, so nothing is left undeclared.
        init_dir = DST_BASE / f"datalib-{m}-module/data/{ns}/function/load"
        init_dir.mkdir(parents=True, exist_ok=True)
        init_path = init_dir / "init.mcfunction"
        init_lines = [f"# {ns}:load/init -- ensures this module's objectives/storages exist"]
        for obj in objectives:
            init_lines.append(f"scoreboard objectives add {obj} dummy")
        for st_id, key in storage_pairs:
            if key:
                init_lines.append(f"execute unless data storage {st_id} {key} run data modify storage {st_id} {key} set value {{}}")
            else:
                # `execute if/unless data storage <id>` requires an NBT path
                # argument -- it cannot be omitted, so a root-level check is
                # not valid syntax. Root-level (re)init is idempotent on its
                # own, so just modify it unconditionally instead of guarding.
                init_lines.append(f"data modify storage {st_id} set value {{}}")
        if not objectives and not storage_pairs:
            init_lines.append("# No module-local scoreboards/storages detected.")
        init_path.write_text("\n".join(init_lines) + "\n", encoding="utf-8")
        init_line = f"function {ns}:load/init"

        # -- cleanup.mcfunction: reset every objective and clear every
        #    storage key this module owns, run on datapack unload/reload.
        cleanup_dir = DST_BASE / f"datalib-{m}-module/data/{ns}/function/load"
        cleanup_path = cleanup_dir / "cleanup.mcfunction"
        cleanup_lines = [f"# {ns}:load/cleanup -- resets this module's scoreboards/storages"]
        for obj in objectives:
            cleanup_lines.append(f"scoreboard players reset * {obj}")
        for st_id, key in storage_pairs:
            # `data remove storage <ns:root>` alone (no key) removes the
            # entire storage root -- valid. `data remove storage <ns:root>
            # <key>` removes just that key -- also valid, and required
            # whenever a specific NBT key was observed in usage.
            if key:
                cleanup_lines.append(f"execute if data storage {st_id} {key} run data remove storage {st_id} {key}")
            else:
                # Same mandatory-path constraint as init: `execute if data
                # storage <id>` alone is not valid syntax. `data remove
                # storage <id>` is idempotent (no-op if already absent), so
                # remove it unconditionally instead of guarding.
                cleanup_lines.append(f"data remove storage {st_id}")
        if not objectives and not storage_pairs:
            cleanup_lines.append("# No module-local scoreboards/storages detected.")
        cleanup_path.write_text("\n".join(cleanup_lines) + "\n", encoding="utf-8")
        cleanup_note = f"# Cleanup: #load:module_cleanup -> {ns}:load/cleanup"

        content = f"""# dl_{m}.load:main -- Stage entry point for the {m} module
scoreboard objectives add dl.{m}.version dummy
scoreboard players set $dl_{m}_version dl.{m}.version 601

{init_line}
{cleanup_note}
"""
        (dir_path / "main.mcfunction").write_text(content, encoding="utf-8")

    # 5. Create pack.mcmeta files
    def get_mcmeta(title, desc_extra=""):
        return {
            "pack": {
                "description": [
                    {"text": title, "color": "#00ccff", "bold": True, "italic": False},
                    {"text": " | by runtoolkit", "color": "#00ff33", "bold": False, "italic": False},
                    {"text": desc_extra, "color": "#ffaa00" if "v6" in desc_extra else "#ff5555", "bold": False, "italic": True}
                ],
                "min_format": 107,
                "max_format": 107
            },
            "features": {"enabled": ["minecraft:vanilla"]}
        }

    (DST_BASE / "datalib-core/pack.mcmeta").write_text(json.dumps(get_mcmeta("D.L. Core", " | v6.0.2"), indent=2, ensure_ascii=False))
    for m in module_list:
        p_dir = DST_BASE / f"datalib-{m}-module"
        (p_dir / "pack.mcmeta").write_text(json.dumps(get_mcmeta(f"D.L. -- {m}", " | requires datalib-core"), indent=2, ensure_ascii=False))

    Logger.success(f"Generated pack.mcmeta and load mains for {len(module_list)} modules.")


def step_16_support_packs():
    Logger.step(16, "Migrate Support Packs (stringlib & player_action)")
    sup_base = TMP_WORK / "packs/support"
    str_dir = sup_base / "stringlib-dp/data"
    pl_dir = sup_base / "player-action-dp/data"

    str_src = TMP_WORK / "datapacks/dataLib/data/stringlib"
    pl_src = TMP_WORK / "datapacks/dataLib/data/player_action"

    if str_src.is_dir():
        shutil.copytree(str_src, str_dir / "stringlib", dirs_exist_ok=True)
    if pl_src.is_dir():
        shutil.copytree(pl_src, pl_dir / "player_action", dirs_exist_ok=True)

    def write_sup_mcmeta(path, name, desc):
        (path / "pack.mcmeta").write_text(json.dumps({
            "pack": {
                "description": [
                    {"text": name, "color": "#00ccff", "bold": True, "italic": False},
                    {"text": " | by runtoolkit", "color": "#00ff33", "bold": False, "italic": False},
                    {"text": f" | {desc}", "color": "#aaaaaa", "bold": False, "italic": True}
                ],
                "min_format": 107, "max_format": 107
            },
            "features": {"enabled": ["minecraft:vanilla"]}
        }, indent=2))

    write_sup_mcmeta(sup_base / "stringlib-dp", "StringLib", "string utility library")
    write_sup_mcmeta(sup_base / "player-action-dp", "Player Action", "player event capture library")

    Logger.success("Support packs successfully extracted.")


def step_17_remap_leftovers():
    Logger.step(17, "Remap Leftover References Across Support/Modules")
    id_table = {}
    if (TMP_ANALYSIS / "id_table.json").is_file():
        id_table = json.loads((TMP_ANALYSIS / "id_table.json").read_text())

    shared = {"engine", "input", "output"}
    token = re.compile(r"\bdatalib:([a-zA-Z0-9_/.\-]+)")

    def classify_fallback(p):
        parts = p.split("/")
        if p.startswith("core/internal/systems/") and len(parts) > 3:
            return f"datalib_{parts[3]}" if parts[3] != "core" else "datalib_core"
        if p.startswith("systems/") and len(parts) > 1:
            return f"datalib_{parts[1]}"
        if p.startswith("api/") and len(parts) > 1:
            return f"datalib_{parts[1]}"
        return "datalib_core"

    def remap_token(m):
        path = m.group(1)
        trail = ""
        core_path = path
        while core_path and core_path[-1] in ".,":
            trail = core_path[-1] + trail
            core_path = core_path[:-1]
        if core_path in shared:
            return f"datalib_core:{core_path}{trail}"
        if core_path in id_table:
            return id_table[core_path] + trail
        ns = classify_fallback(core_path)
        return f"{ns}:{core_path}{trail}"

    changed = 0
    for root_name in ("packs/support", "packs/modules"):
        root = TMP_WORK / root_name
        if not root.is_dir(): continue
        for dirpath, _, files in os.walk(root):
            for fn in files:
                if not fn.endswith((".json", ".mcfunction")): continue
                full = Path(dirpath) / fn
                content = full.read_text(encoding="utf-8", errors="replace")
                
                content = re.sub(r'dl_load:', 'datalib_core:load_gate/', content)
                content = re.sub(r'playsound datalib_core:', 'playsound datalib:', content)

                if "datalib:" in content:
                    new_content = token.sub(remap_token, content)
                    if new_content != content:
                        full.write_text(new_content, encoding="utf-8")
                        changed += 1
                        Logger.debug(f"Remapped: {full.relative_to(TMP_WORK)}")
                else:
                    full.write_text(content, encoding="utf-8")

    Logger.success(f"Leftover namespace cleanups completed. Modified files: {changed}")


def step_18_lint_and_validate():
    Logger.step(18, "Lint SNBT Syntax & Validate JSON Files")
    packs_dir = TMP_WORK / "packs"
    
    # SNBT Linting
    issues = []
    total_files = 0
    bool_pattern = re.compile(r':\s*(true|false)\b')
    # Matches only the {...} NBT payload following `data modify/merge ... storage <ns:path>`,
    # so text-component JSON (tellraw/title/etc.) and quoted string literals
    # elsewhere on the line are never scanned.
    nbt_block_pattern = re.compile(r'\bdata\s+(?:modify|merge)\b[^{"]*\bstorage\b[^{"]*(\{.*?\})(?=\s|$)')

    for dirpath, _, files in os.walk(packs_dir):
        for fn in files:
            if not fn.endswith(".mcfunction"): continue
            total_files += 1
            full = Path(dirpath) / fn
            with open(full, encoding="utf-8", errors="replace") as f:
                for lineno, line in enumerate(f, 1):
                    stripped = line.strip()
                    if stripped.startswith("#"): continue
                    for block_match in nbt_block_pattern.finditer(line):
                        nbt_block = block_match.group(1)
                        for m in bool_pattern.finditer(nbt_block):
                            issues.append((str(full.relative_to(packs_dir)), lineno, stripped[:120]))

    Logger.info(f"Total .mcfunction files linted: {total_files}")
    if issues:
        Logger.warn(f"Suspicious SNBT boolean lines detected (should be 1b/0b): {len(issues)}")
        for issue in issues[:5]:
            Logger.debug(f"  Line {issue[1]} in {issue[0]}: {issue[2]}")
    else:
        Logger.success("SNBT Linter passed without warnings.")

    (TMP_ANALYSIS / "lint_report.txt").write_text(
        f"Total .mcfunction files: {total_files}\nSuspicious line count: {len(issues)}\n" +
        "\n".join([str(i) for i in issues]), 
        encoding="utf-8"
    )

    # Validate JSON
    bad, total_json = 0, 0
    for dirpath, _, files in os.walk(packs_dir):
        for fn in files:
            if fn.endswith(".json"):
                total_json += 1
                full = Path(dirpath) / fn
                try:
                    json.loads(full.read_text(encoding="utf-8"))
                except Exception as e:
                    Logger.error(f"Broken JSON: {full.relative_to(packs_dir)} -> {e}")
                    bad += 1

    Logger.info(f"Total JSON files validated: {total_json}")
    if bad > 0:
        Logger.error(f"Validation FAILED! Found {bad} malformed JSON files.")
        sys.exit(1)
    else:
        Logger.success("All JSON files are valid.")


def step_19_build_zips():
    Logger.step(19, "Build Distributable Pack Artifacts")
    DIST_DIR.mkdir(parents=True, exist_ok=True)
    
    packs_to_zip = []
    for root_name in ("packs/modules", "packs/support"):
        root = TMP_WORK / root_name
        if not root.is_dir(): continue
        for name in sorted(os.listdir(root)):
            pack_dir = root / name
            if pack_dir.is_dir():
                packs_to_zip.append((name, pack_dir))

    def zip_pack(pack_dir, zip_path):
        with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
            for dirpath, _, files in os.walk(pack_dir):
                for fn in files:
                    full = Path(dirpath) / fn
                    arc = full.relative_to(pack_dir)
                    zf.write(full, arc)

    total_zips = len(packs_to_zip)
    for i, (name, pack_dir) in enumerate(packs_to_zip, 1):
        zip_path = DIST_DIR / f"{name}.zip"
        zip_pack(pack_dir, zip_path)
        Logger.progress_bar(i, total_zips, prefix="Packing Zips", suffix=f"{name}.zip")

    Logger.success(f"Successfully generated {total_zips} ZIP archives at: {Logger.UNDERLINE}{DIST_DIR}{Logger.RESET}")


# ==============================================================================
# Main Orchestration Engine
# ==============================================================================
def main():
    start_time = time.time()
    Logger.banner("dataLib-dp Migration Engine v6.0")

    step_1_backup()
    step_2_prepare_work_dir()
    step_3_verify_layout()
    step_4_move_fabric_files()
    step_5_clean_deps()
    step_6_build_function_graph()
    step_7_prepare_core_skeleton()
    step_8c_relocate_root_dirs_to_api()
    step_8_build_module_map()
    step_8b_resolve_underscore_dirs()
    step_9_migrate_functions()
    step_10_migrate_dlload()
    step_11_create_tags_and_ticks()
    step_12_migrate_extras()
    step_13_migrate_tags()
    step_14_cleanup_old_module_dirs()
    step_15_post_fixes()
    step_16_support_packs()
    step_17_remap_leftovers()
    step_18_lint_and_validate()
    step_19_build_zips()

    elapsed = time.time() - start_time
    
    print("\n" + f"{Logger.CYAN}═{Logger.RESET}" * 65)
    Logger.info(f"{Logger.BOLD}Total Execution Time:{Logger.RESET} {elapsed:.2f} seconds")
    Logger.banner("MIGRATION PIPELINE COMPLETED SUCCESSFULLY")

if __name__ == "__main__":
    main()