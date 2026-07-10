# cos(x) = sin(x + 90)
$scoreboard players set $cos_d dl.tmp $(deg)
scoreboard players add $cos_d dl.tmp 90
scoreboard players set $cos_360 dl.tmp 360
scoreboard players operation $cos_d dl.tmp %= $cos_360 dl.tmp
execute if score $cos_d dl.tmp matches ..-1 run scoreboard players operation $cos_d dl.tmp += $cos_360 dl.tmp

scoreboard players set $cos_nf dl.tmp 1
execute if score $cos_d dl.tmp matches 180..359 run scoreboard players set $cos_nf dl.tmp -1
execute if score $cos_d dl.tmp matches 180..359 run scoreboard players remove $cos_d dl.tmp 180

scoreboard players set $cos_180 dl.tmp 180
execute if score $cos_d dl.tmp matches 91..179 run scoreboard players operation $cos_180 dl.tmp -= $cos_d dl.tmp
execute if score $cos_d dl.tmp matches 91..179 run scoreboard players operation $cos_d dl.tmp = $cos_180 dl.tmp

execute if score $cos_d dl.tmp matches 0 run scoreboard players set $cos_r dl.tmp 0
execute if score $cos_d dl.tmp matches 1 run scoreboard players set $cos_r dl.tmp 17
execute if score $cos_d dl.tmp matches 2 run scoreboard players set $cos_r dl.tmp 35
execute if score $cos_d dl.tmp matches 3 run scoreboard players set $cos_r dl.tmp 52
execute if score $cos_d dl.tmp matches 4 run scoreboard players set $cos_r dl.tmp 70
execute if score $cos_d dl.tmp matches 5 run scoreboard players set $cos_r dl.tmp 87
execute if score $cos_d dl.tmp matches 6 run scoreboard players set $cos_r dl.tmp 105
execute if score $cos_d dl.tmp matches 7 run scoreboard players set $cos_r dl.tmp 122
execute if score $cos_d dl.tmp matches 8 run scoreboard players set $cos_r dl.tmp 139
execute if score $cos_d dl.tmp matches 9 run scoreboard players set $cos_r dl.tmp 156
execute if score $cos_d dl.tmp matches 10 run scoreboard players set $cos_r dl.tmp 174
execute if score $cos_d dl.tmp matches 11 run scoreboard players set $cos_r dl.tmp 191
execute if score $cos_d dl.tmp matches 12 run scoreboard players set $cos_r dl.tmp 208
execute if score $cos_d dl.tmp matches 13 run scoreboard players set $cos_r dl.tmp 225
execute if score $cos_d dl.tmp matches 14 run scoreboard players set $cos_r dl.tmp 242
execute if score $cos_d dl.tmp matches 15 run scoreboard players set $cos_r dl.tmp 259
execute if score $cos_d dl.tmp matches 16 run scoreboard players set $cos_r dl.tmp 276
execute if score $cos_d dl.tmp matches 17 run scoreboard players set $cos_r dl.tmp 292
execute if score $cos_d dl.tmp matches 18 run scoreboard players set $cos_r dl.tmp 309
execute if score $cos_d dl.tmp matches 19 run scoreboard players set $cos_r dl.tmp 326
execute if score $cos_d dl.tmp matches 20 run scoreboard players set $cos_r dl.tmp 342
execute if score $cos_d dl.tmp matches 21 run scoreboard players set $cos_r dl.tmp 358
execute if score $cos_d dl.tmp matches 22 run scoreboard players set $cos_r dl.tmp 375
execute if score $cos_d dl.tmp matches 23 run scoreboard players set $cos_r dl.tmp 391
execute if score $cos_d dl.tmp matches 24 run scoreboard players set $cos_r dl.tmp 407
execute if score $cos_d dl.tmp matches 25 run scoreboard players set $cos_r dl.tmp 423
execute if score $cos_d dl.tmp matches 26 run scoreboard players set $cos_r dl.tmp 438
execute if score $cos_d dl.tmp matches 27 run scoreboard players set $cos_r dl.tmp 454
execute if score $cos_d dl.tmp matches 28 run scoreboard players set $cos_r dl.tmp 469
execute if score $cos_d dl.tmp matches 29 run scoreboard players set $cos_r dl.tmp 485
execute if score $cos_d dl.tmp matches 30 run scoreboard players set $cos_r dl.tmp 500
execute if score $cos_d dl.tmp matches 31 run scoreboard players set $cos_r dl.tmp 515
execute if score $cos_d dl.tmp matches 32 run scoreboard players set $cos_r dl.tmp 530
execute if score $cos_d dl.tmp matches 33 run scoreboard players set $cos_r dl.tmp 545
execute if score $cos_d dl.tmp matches 34 run scoreboard players set $cos_r dl.tmp 559
execute if score $cos_d dl.tmp matches 35 run scoreboard players set $cos_r dl.tmp 574
execute if score $cos_d dl.tmp matches 36 run scoreboard players set $cos_r dl.tmp 588
execute if score $cos_d dl.tmp matches 37 run scoreboard players set $cos_r dl.tmp 602
execute if score $cos_d dl.tmp matches 38 run scoreboard players set $cos_r dl.tmp 616
execute if score $cos_d dl.tmp matches 39 run scoreboard players set $cos_r dl.tmp 629
execute if score $cos_d dl.tmp matches 40 run scoreboard players set $cos_r dl.tmp 643
execute if score $cos_d dl.tmp matches 41 run scoreboard players set $cos_r dl.tmp 656
execute if score $cos_d dl.tmp matches 42 run scoreboard players set $cos_r dl.tmp 669
execute if score $cos_d dl.tmp matches 43 run scoreboard players set $cos_r dl.tmp 682
execute if score $cos_d dl.tmp matches 44 run scoreboard players set $cos_r dl.tmp 695
execute if score $cos_d dl.tmp matches 45 run scoreboard players set $cos_r dl.tmp 707
execute if score $cos_d dl.tmp matches 46 run scoreboard players set $cos_r dl.tmp 719
execute if score $cos_d dl.tmp matches 47 run scoreboard players set $cos_r dl.tmp 731
execute if score $cos_d dl.tmp matches 48 run scoreboard players set $cos_r dl.tmp 743
execute if score $cos_d dl.tmp matches 49 run scoreboard players set $cos_r dl.tmp 755
execute if score $cos_d dl.tmp matches 50 run scoreboard players set $cos_r dl.tmp 766
execute if score $cos_d dl.tmp matches 51 run scoreboard players set $cos_r dl.tmp 777
execute if score $cos_d dl.tmp matches 52 run scoreboard players set $cos_r dl.tmp 788
execute if score $cos_d dl.tmp matches 53 run scoreboard players set $cos_r dl.tmp 799
execute if score $cos_d dl.tmp matches 54 run scoreboard players set $cos_r dl.tmp 809
execute if score $cos_d dl.tmp matches 55 run scoreboard players set $cos_r dl.tmp 819
execute if score $cos_d dl.tmp matches 56 run scoreboard players set $cos_r dl.tmp 829
execute if score $cos_d dl.tmp matches 57 run scoreboard players set $cos_r dl.tmp 839
execute if score $cos_d dl.tmp matches 58 run scoreboard players set $cos_r dl.tmp 848
execute if score $cos_d dl.tmp matches 59 run scoreboard players set $cos_r dl.tmp 857
execute if score $cos_d dl.tmp matches 60 run scoreboard players set $cos_r dl.tmp 866
execute if score $cos_d dl.tmp matches 61 run scoreboard players set $cos_r dl.tmp 875
execute if score $cos_d dl.tmp matches 62 run scoreboard players set $cos_r dl.tmp 883
execute if score $cos_d dl.tmp matches 63 run scoreboard players set $cos_r dl.tmp 891
execute if score $cos_d dl.tmp matches 64 run scoreboard players set $cos_r dl.tmp 899
execute if score $cos_d dl.tmp matches 65 run scoreboard players set $cos_r dl.tmp 906
execute if score $cos_d dl.tmp matches 66 run scoreboard players set $cos_r dl.tmp 914
execute if score $cos_d dl.tmp matches 67 run scoreboard players set $cos_r dl.tmp 921
execute if score $cos_d dl.tmp matches 68 run scoreboard players set $cos_r dl.tmp 927
execute if score $cos_d dl.tmp matches 69 run scoreboard players set $cos_r dl.tmp 934
execute if score $cos_d dl.tmp matches 70 run scoreboard players set $cos_r dl.tmp 940
execute if score $cos_d dl.tmp matches 71 run scoreboard players set $cos_r dl.tmp 946
execute if score $cos_d dl.tmp matches 72 run scoreboard players set $cos_r dl.tmp 951
execute if score $cos_d dl.tmp matches 73 run scoreboard players set $cos_r dl.tmp 956
execute if score $cos_d dl.tmp matches 74 run scoreboard players set $cos_r dl.tmp 961
execute if score $cos_d dl.tmp matches 75 run scoreboard players set $cos_r dl.tmp 966
execute if score $cos_d dl.tmp matches 76 run scoreboard players set $cos_r dl.tmp 970
execute if score $cos_d dl.tmp matches 77 run scoreboard players set $cos_r dl.tmp 974
execute if score $cos_d dl.tmp matches 78 run scoreboard players set $cos_r dl.tmp 978
execute if score $cos_d dl.tmp matches 79 run scoreboard players set $cos_r dl.tmp 982
execute if score $cos_d dl.tmp matches 80 run scoreboard players set $cos_r dl.tmp 985
execute if score $cos_d dl.tmp matches 81 run scoreboard players set $cos_r dl.tmp 988
execute if score $cos_d dl.tmp matches 82 run scoreboard players set $cos_r dl.tmp 990
execute if score $cos_d dl.tmp matches 83 run scoreboard players set $cos_r dl.tmp 993
execute if score $cos_d dl.tmp matches 84 run scoreboard players set $cos_r dl.tmp 995
execute if score $cos_d dl.tmp matches 85 run scoreboard players set $cos_r dl.tmp 996
execute if score $cos_d dl.tmp matches 86 run scoreboard players set $cos_r dl.tmp 998
execute if score $cos_d dl.tmp matches 87 run scoreboard players set $cos_r dl.tmp 999
execute if score $cos_d dl.tmp matches 88 run scoreboard players set $cos_r dl.tmp 999
execute if score $cos_d dl.tmp matches 89 run scoreboard players set $cos_r dl.tmp 1000
execute if score $cos_d dl.tmp matches 90 run scoreboard players set $cos_r dl.tmp 1000

scoreboard players operation $cos_r dl.tmp *= $cos_nf dl.tmp
execute store result storage datalib:output result int 1 run scoreboard players get $cos_r dl.tmp
$tellraw @a[tag=datalib.debug] ["",{"text":"[DL] ","color":"#00AAAA","bold":true},{"text":"math/cos ","color":"aqua"},{"text":"deg=$(deg) ","color":"gray"},{"text":"→ ","color":"#555555"},{"storage":"datalib:output","nbt":"result","color":"green"},{"text":"/1000","color":"#555555"}]
