# Called during every load — only writes defaults if channels don't exist yet.
# This preserves any runtime customisations made via the channel API.
# To reset to file defaults: function datalib:core/tick/reset_channels
execute unless data storage datalib:engine tick.channels run function datalib:core/tick/config