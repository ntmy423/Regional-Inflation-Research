/* Purpose: Merging pre- & post-COVID inflation rates data with population growth rates data

Last modified: MN, 03/24/2025  

*/

* Retain pre- & post-COVID population growth data
use  "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_growth_long_20_23.dta", clear
gen GeoFIPS_str = string(GeoFIPS, "%05.0f")
drop GeoFIPS
rename GeoFIPS_str GeoFIPS
gen GeoFIPS_new = substr(GeoFIPS, 1, 5)
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
describe GeoFIPS
order GeoFIPS Year pop_growth
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_growth_newGeoFIPS.dta", replace

* Retain pre- & post-COVID inflation rates data
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoFIPS_Price_infl.dta", clear
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS inf
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoFIPSnew_Price_infl.dta", replace

* Merge two datasets (inflation rates data and population growth rates data)
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_growth_newGeoFIPS.dta", clear
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoFIPSnew_Price_infl.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/pop_growth_inf.dta", replace
