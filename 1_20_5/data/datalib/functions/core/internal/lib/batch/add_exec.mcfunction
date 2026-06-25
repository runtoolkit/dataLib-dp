# datalib:core/internal/lib/batch/add_exec [MACRO]
# INPUT: $(id)
# func or cmd field existence is checked outside the macro,
# then the relevant append_func / append_cmd is called — prevents undefined $(func/cmd).

$execute unless data storage datalib:engine batches.$(id) run return 0

execute if data storage datalib:input func run function datalib:core/internal/lib/batch/add_func with storage datalib:engine
execute if data storage datalib:input cmd run function datalib:core/internal/lib/batch/add_cmd with storage datalib:engine
