# datalib:api/security/allowlist_clear
# Clears the entire sandbox_allowlist (all prefixes blocked in sandbox mode).
data modify storage datalib:engine security.sandbox_allowlist set value {}
tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"security/allowlist_clear ","color":"aqua"},{"text":"✔ cleared","color":"green"}]
