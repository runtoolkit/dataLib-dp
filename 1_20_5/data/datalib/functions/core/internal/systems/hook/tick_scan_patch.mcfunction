# ─────────────────────────────────────────────────────────────────
# PATCH — lines to append to datalib:core/internal/systems/hook/tick_scan
# (after the "# hero_of_the_village" block in the existing file)
# ─────────────────────────────────────────────────────────────────

# dimension_change — changed_dimension advancement-based, score increase
execute as @a[scores={datalib.hook_dim_changed=1..}] run function datalib:core/internal/systems/hook/on_dimension_change
execute as @a[scores={datalib.hook_dim_changed=1..}] run scoreboard players set @s datalib.hook_dim_changed 0

# trade — villager_trade advancement-based, score increase
execute as @a[scores={datalib.hook_traded=1..}] run function datalib:core/internal/systems/hook/on_trade
execute as @a[scores={datalib.hook_traded=1..}] run scoreboard players set @s datalib.hook_traded 0
