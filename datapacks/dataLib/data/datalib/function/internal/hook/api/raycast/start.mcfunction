# Raycast start
# Reset distance counter (max 50 steps = 5 blocks)
scoreboard players set @s dl.tmp 0

# Start loop
function datalib:internal/hook/api/raycast/loop
