# Advancement reward: runs when placed_block triggers
# Find the newly placed block in the direction the player is looking

# Revoke advancement (so it can trigger again)
advancement revoke @s only datalib:systems/hook/placed_block

# Start raycast: begin from player's eyes
execute as @s at @s anchored eyes run function datalib:systems/hook/raycast/start
