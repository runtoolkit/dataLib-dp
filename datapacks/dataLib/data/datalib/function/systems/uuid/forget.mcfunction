# ============================================================
# datalib:systems/uuid/forget
# Deletes a UUID entry from the cache
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# function datalib:systems/uuid/forget
#
# INPUT:
# datalib:input key → name of the key to delete
# ============================================================
function datalib:core/internal/systems/uuid/forget_key with storage datalib:input
