# datalib:systems/hook/on_trade
# Advancement reward: runs when villager_trade triggers.
# @s = the trading player

advancement revoke @s only datalib:systems/hook/trade
scoreboard players add @s datalib.hook_traded 1
