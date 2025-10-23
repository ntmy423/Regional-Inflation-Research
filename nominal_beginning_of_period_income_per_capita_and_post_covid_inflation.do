/* Purpose: Merging nominal beginning-of-period income per capita and post-COVID inflation; Creating scatterplot showing the relationship between nominal beginning-of-period income per capita and post-COVID inflation

Last modified: MN, 03/24/2025  

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/RPP_RPI_PCE_Pop_17_23.dta", clear
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal inc_17_23_long.dta"
drop if _merge != 3
drop _merge
order GeoFIPS GeoName Year rpp rpi PCE inc POPESTIMATE
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inc_RPP_RPI_PCE_Pop_17_23.dta", replace
gen inc_pop = inc/POPESTIMATE
keep if Year == 2020
drop Year rpp rpi inc PCE POPESTIMATE
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/beginning of period inc_pop.dta", replace

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
drop if Year == 2020
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS GeoName Year inf
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/beginning of period inc_pop.dta"
drop if _merge != 3
drop _merge
drop Year
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/beginning of period inc_pop & post covid infl.dta", replace

* Creating scatterplot showing the relationship between nominal beginning-of-period income per capita and post-COVID inflation
binscatter inf inc_pop
