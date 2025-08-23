clear
set memory 12m
set matsize 250

use davis.dta, clear

keep landvalue msa date

reshape wide landvalue, i(msa) j(date)

** PREPARE DATA **
* Note: all prices are expressed in terms of the service price: 1.20450232 is the service price in 2005 relative to that in 1995 (see worksheet "RelativePrices" in file "Table1&Figure2-7.xls")

gen loglandvalue19952=log(landvalue19952)
gen loglandvalue20052=log(landvalue20052/1.204502302)
rename loglandvalue19952 lv1995
rename loglandvalue20052 lv2005

** COMPUTE DENSITY ** 

kdensity lv1995, gen (x1995 d1995) at (lv1995)
kdensity lv2005, gen (x2005 d2005) at (lv2005)
list x1995 d1995, clean
list x2005 d2005, clean

keep msa x1995 d1995 x2005 d2005

save davisdensity19852005.dta, replace

