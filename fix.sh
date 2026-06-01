#!/usr/bin/env bash

sed -i 's/with storage datalib:engine {}/with storage datalib:engine _log_add_tmp/g' 1_20_5/data/dl_load/functions/load/all.mcfunction

sed -i 's/with storage datalib:engine {}/with storage datalib:engine _log_add_tmp/g' 1_20_5/data/dl_load/functions/core/internal/load/validate.mcfunction

sed -i 's/with storage datalib:engine {}/with storage datalib:engine _log_add_tmp/g' 1_20_5/data/dl_load/functions/core/internal/load/finalize.mcfunction

sed -i 's/with storage datalib:engine {}/with storage datalib:engine _log_add_tmp/g' 1_20_5/data/dl_load/functions/core/internal/load/version_warn.mcfunction

git add .
git commit -m "fix: resolve execution parsing crashes on load module"
git push