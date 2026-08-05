# datalib:systems/hook/on_break_block
# Reward: break_block advancement (item_durability_changed, delta max -1)
# Feeds both break_block and using_item hooks.
advancement revoke @s only datalib:systems/hook/break_block
scoreboard players add @s datalib.hook_tool_used 1
scoreboard players add @s datalib.hook_using_item 1
