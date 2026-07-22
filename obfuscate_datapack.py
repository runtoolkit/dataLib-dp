from pathlib import Path
from random import randint
import os

# ====================== SETTINGS ======================
# Namespaces you don't want to encrypt
keep_namespaces = []

# Length of randomized binary names (16 is safe)
filename_length = 16
# =====================================================

pathname_list = []

def get_random_pathname():
    global pathname_list
    while True:
        pathname = "".join(str(randint(0, 1)) for _ in range(filename_length))
        if pathname not in pathname_list:
            pathname_list.append(pathname)
            return pathname


def create_conversion_table(path_list):
    return {path: get_random_pathname() for path in path_list}


def remove_protected_namespaces(path_list, protected):
    i = 0
    while i < len(path_list):
        parts = Path(path_list[i]).parts
        if len(parts) > 2 and parts[2] in protected:
            del path_list[i]
            i -= 1
        else:
            i += 1


def only_keep_function_folder(path_list):
    """Support both old 'functions' and new 'function' folders"""
    i = 0
    while i < len(path_list):
        parts = Path(path_list[i]).parts
        if len(parts) > 3 and parts[3] in ("functions", "function"):
            i += 1
        else:
            del path_list[i]
            i -= 1


def only_keep_mcfunctions(path_list):
    i = 0
    while i < len(path_list):
        if str(path_list[i]).endswith(".mcfunction"):
            i += 1
        else:
            del path_list[i]
            i -= 1


def sort_by_depth_desc(path_list):
    path_list.sort(key=lambda p: len(Path(p).parts), reverse=True)


def get_parent(path_str):
    return str(Path(path_str).parent)


# ====================== MAIN ======================

print("Scanning files...")

path_list = [str(x) for x in Path("target/data").glob("**/*")]

protected = ["minecraft"] + keep_namespaces
remove_protected_namespaces(path_list, protected)
only_keep_function_folder(path_list)
sort_by_depth_desc(path_list)

conversion_table = create_conversion_table(path_list)

origin_dir = os.getcwd()

print("ROUND 1: Renaming folders and .mcfunction files...")

for path in path_list:
    os.chdir(origin_dir)
    new_name = conversion_table[path]
    p = Path(path)
    parent = p.parent
    
    if p.is_file():
        p.rename(parent / f"{new_name}.mcfunction")
    else:
        p.rename(parent / new_name)

# ====================== ROUND 2: Update internal calls ======================

print("ROUND 2: Updating function calls in .mcfunction files...")

mcfunction_list = [str(x) for x in Path("target/data").glob("**/*")]
only_keep_function_folder(mcfunction_list)
only_keep_mcfunctions(mcfunction_list)
sort_by_depth_desc(mcfunction_list)

for mc_path_str in mcfunction_list:
    mc_path = Path(mc_path_str)
    
    with open(mc_path, "r", encoding="utf-8") as f:
        lines = f.readlines()
    
    new_lines = []
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("#") or "function " not in line:
            new_lines.append(line.rstrip())
            continue
        
        words = line.split()
        new_words = []
        i = 0
        while i < len(words):
            w = words[i]
            new_words.append(w)
            
            if w == "function" and i + 1 < len(words):
                i += 1
                func = words[i]
                
                if ":" in func:
                    ns, rel_path = func.split(":", 1)
                    if ns in keep_namespaces:
                        new_words.append(func)
                    else:
                        parts = rel_path.split("/")
                        new_parts = []
                        current_base = Path("target/data") / ns / "function"  # modern folder
                        for k, part in enumerate(parts):
                            current = current_base / "/".join(parts[:k+1])
                            current_str = str(current)
                            # Fallback to old folder name if needed
                            if current_str not in conversion_table:
                                current_str = str(Path("target/data") / ns / "functions" / "/".join(parts[:k+1]))
                            new_parts.append(conversion_table.get(current_str, part))
                        new_func = f"{ns}:{'/'.join(new_parts)}"
                        new_words.append(new_func)
                else:
                    new_words.append(func)
            i += 1
        
        new_lines.append(" ".join(new_words))
    
    with open(mc_path, "w", encoding="utf-8") as f:
        f.write("\n".join(new_lines))

print("Encryption completed.")
print(f"Processed {len(conversion_table)} items.")
