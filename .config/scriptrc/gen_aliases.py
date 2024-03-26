# not that pretty, but needs it to be pretty fast
import os
from shutil import which


IGNORE = ["go", "parallels", "tmp", "library"]
MAX_DEPTH = 5
ENDING_DIRS = [".git", ".svn", ".hg", ".venv"]


def subdirs(path):
    return [d for d in os.listdir(path) if not d.startswith(".") and os.path.isdir(os.path.join(path, d))]


def gen_aliases(dirs, prefix="", subpath=""):
    if len(dirs) == 0:
        return {}

    aliases = {}

    for d in dirs:
        if " " in d:
            # who uses spaces in directory names anyway?
            continue

        for i in range(1, len(d)):
            k = d.lower()[:i]

            if i == len(d) - 1:
                aliases[prefix + d.lower()] = os.path.join(subpath, d)
                break

            if all([dd == d or not dd.lower().startswith(k) for dd in dirs]) and not which(prefix + k):
                aliases[prefix + k] = os.path.join(subpath, d)
                break

    return aliases


def process_dir(path, prefix="", depth=0):
    if depth >= MAX_DEPTH:
        return {}

    for subdir in ENDING_DIRS:
        if os.path.exists(os.path.abspath(os.path.join(path, "..", subdir))):
            return {}

    dirs = subdirs(path)
    if depth == 0:
        dirs = [d for d in dirs if all([i not in d.lower() for i in IGNORE])]

    aliases = gen_aliases(dirs, prefix, path)

    # we can go deeper
    for pref, pth in aliases.copy().items():
        aliases.update(process_dir(pth, pref, depth + 1))

    return aliases


def gen_alias(alias_name, path):
    cmd = f"cd {path}"
    return "alias {}='{}'".format(alias_name, cmd)



print("Generating aliases...")

ALIASES = []

for alias_name, path in process_dir(os.path.expanduser("~")).items():
    ALIASES.append(gen_alias(alias_name, path))

if not os.path.exists(os.path.expanduser("~/.cache")):
    os.path.mkdir(os.path.expanduser("~/.cache"))

with open(os.path.expanduser("~/.cache/aliases"), "w") as f:
    f.write("\n".join(ALIASES))

print("Done!")
