# ============================================================
# datalib:modules/uuid/api/forget
# Deletes a UUID entry from the cache
#
# KULLANIM:
# data modify storage datalib:input key set value "benim_anahtarim"
# function datalib:modules/uuid/api/forget
#
# INPUT:
# datalib:input key → name of the key to delete
# ============================================================
function datalib:modules/uuid/internal/forget_key with storage datalib:input
