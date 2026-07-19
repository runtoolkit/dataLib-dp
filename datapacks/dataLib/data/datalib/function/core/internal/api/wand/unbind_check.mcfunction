# datalib:api/wand/internal/unbind_check [MACRO]
# $(tag) is the tag of the current record. Add back if it does not match _wand_filter_tag.

$execute unless data storage datalib:engine {_wand_filter_tag:"$(tag)"} run data modify storage datalib:engine wand_binds append from storage datalib:engine _wand_cur
