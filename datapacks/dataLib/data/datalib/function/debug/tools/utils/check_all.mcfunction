#> ARCHIVED: dataLib-dp is no longer maintained.
#> The security check chain below (load_check / perm_check / input_check) runs UNCHANGED.
#> Since no new security patches will be released, keeping this datapack in production is risky.
#> Recommended: migrate to the runtoolkit Fabric mod ecosystem (MC 1.21.1, upgrade to 1.21.11 if needed).

execute unless function datalib:debug/tools/utils/load_check run return 0
execute unless function datalib:debug/tools/utils/perm_check run return 0
execute unless function datalib:debug/tools/utils/input_check run return 0
return 1
