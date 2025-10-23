/* Purpose: Merging population growth rate and inflation data with local real personal income data

Last modified: MN, 03/24/2025  

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/pop_growth_inf.dta", clear
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPI_infl_17_23.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/pop_growth_inf_rpi.dta", replace
