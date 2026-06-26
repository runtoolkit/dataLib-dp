import os
import json

OUTPUT = "build.py"
ROOT   = "./data"
MCMETA = "./pack.mcmeta"
EXTS   = (".mcfunction", ".json", ".mcmeta")

FILES = []
SEEN  = set()

def collect(directory):
    for root, dirs, files in os.walk(directory):
        dirs.sort()
        for name in sorted(files):
            if not name.endswith(EXTS):
                continue
            path = os.path.join(root, name)
            if path in SEEN:
                continue
            SEEN.add(path)
            try:
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
            except Exception as e:
                print(f"[SKIP] {path}: {e}")
                continue
            FILES.append((path, content))

# -------------------------
# Add pack.mcmeta
# -------------------------
if os.path.isfile(MCMETA):
    try:
        with open(MCMETA, "r", encoding="utf-8") as f:
            FILES.append((MCMETA, f.read()))
        SEEN.add(MCMETA)
        print("[INFO] pack.mcmeta found.")
    except Exception as e:
        print(f"[SKIP] pack.mcmeta: {e}")
else:
    print("[WARN] pack.mcmeta missing — no overlay scan.")

# -------------------------
# Main data
# -------------------------
collect(ROOT)

# -------------------------
# Overlay parsing
# -------------------------
overlays = []
if os.path.isfile(MCMETA):
    try:
        with open(MCMETA, "r", encoding="utf-8") as f:
            meta = json.load(f)
        entries = meta.get("overlays", {}).get("entries", [])
        overlays = [e["directory"] for e in entries if "directory" in e]
    except Exception as e:
        print(f"[WARN] overlay parse error: {e}")

# -------------------------
# Overlay data scan
# -------------------------
for overlay in overlays:
    overlay_data = os.path.join(".", overlay, "data")
    if os.path.isdir(overlay_data):
        before = len(FILES)
        collect(overlay_data)
        print(f"[INFO] Overlay '{overlay}': {len(FILES) - before} files.")
    else:
        print(f"[WARN] Overlay not found: {overlay_data}")

print(f"[INFO] Total {len(FILES)} files.")

# -------------------------
# Write build.py (FIXED)
# -------------------------
with open(OUTPUT, "w", encoding="utf-8") as out:
    out.write("import os\n\n")
    out.write(f"# Auto-generated — {len(FILES)} files\n\n")
    out.write("FILES = [\n")
    for p, c in FILES:
        # LOSSLESS + SYNTAX SAFE
        out.write(f"    ({p!r}, {c!r}),\n")
    out.write("]\n\n")
    out.write("""\
for path, content in FILES:
    d = os.path.dirname(path)
    if d:
        os.makedirs(d, exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
print(f"OK — {len(FILES)} files extracted.")
""")

print(f"[OK] {OUTPUT} written.")
