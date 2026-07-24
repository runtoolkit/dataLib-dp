#> This function will run on datapack loading

#> ARCHIVED: This datapack is no longer under active development.
#> The security gate/approval system (dl_load:gate/*, core/security/cmd_gate) has NOT been disabled
#> and continues to run as-is. No new features or fixes will be added.
#> Recommended: migrate to the runtoolkit Fabric mod ecosystem (MC 1.21.1, upgrade to 1.21.11 if needed).
tellraw @a[tag=!rt_dl_archive_seen] {"text":"[dataLib] This datapack is ARCHIVED. The security gate still runs, but it is no longer maintained. Migration to a runtoolkit Fabric mod is recommended.","color":"red"}
tag @a add rt_dl_archive_seen

execute if data storage datalib:engine {global:{loaded:1b}} run return 0

function #load:_private/load