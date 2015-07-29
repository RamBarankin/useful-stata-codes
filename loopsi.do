version 13
clear all
set more off
set logtype text
set more off
capture log close
cd "/Users/ram.barankin001/Dropbox/B - Economatrics/Work"
log using "HW3_Q1.txt", replace text
use compustat_data.dta, clear


local countav 0
local countmed 0
local counteq 0
foreach n of varlist at ch ebit lt {
forvalues i =1987/2008{
quietly sum `n' if year==`i', detail 
local dif = r(mean)-r(p50) 
if `dif'>0 display "For " "`n'" " in " "`i'" ", the mean is bigger than the meadian. The difference is "`dif' "." 
else if `dif'<0 display "For " "`n'" " in " "`i'" ", the median is bigger than the mean. The difference is " -1*`dif '"."
else display "For " "`n'" " in " "`i'" ", the mean and the median are equal" "."
if `dif'>0 local countav = `countav' +1
else if `dif'<0 local count = `countmed' +1
else local count = `counteq' +1
}
}
display in red "There were `countav' incidents where the mean was bigger than the median."
display in red "There were `countmed' incidents where the median was bigger than the mean."
display in red "There were `counteq' incidents where the median was equal to the mean."

save loops.dta, replace
log close
