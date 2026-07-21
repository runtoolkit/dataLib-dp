# dl_load:resolve/security
# Validates that datalib:engine security fields expected by this build
# (v6.0.1-pre2) exist after loader/storages runs. Companion check to
# dl_load:resolve/version — catches a security compound left in a
# stale/partial shape by an interrupted prior load or a hand-edited
# storage NBT, rather than trusting the 'unless data' guards in
# loader/storages to have already produced a complete compound.
#
# WARN only — mirrors resolve/dependencies: notifies datalib.debug,
# does not abort load. A hard abort here would be redundant with
# resolve/version, which already owns the abort path for this pipeline.

execute unless data storage datalib:engine security.auto_debug_tag run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"security.auto_debug_tag missing after loader/storages — partial security compound","color":"yellow"}]

execute unless data storage datalib:engine security.multi_type_allowlist run tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"⚠ ","color":"yellow"},{"text":"security.multi_type_allowlist missing after loader/storages — partial security compound","color":"yellow"}]

return 1
