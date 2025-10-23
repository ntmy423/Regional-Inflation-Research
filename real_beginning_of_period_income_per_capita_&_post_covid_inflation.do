/* Purpose: Merging local real beginning-of-period income per capita with post-COVID inflation rates data; Creating scatterplot showing the relationship between local real beginning-of-period income per capita and post-COVID inflation rates

Last modified: MN, 03/24/2025

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/RPP_RPI_PCE_Pop_17_23.dta", clear
gen rpi_pop = rpi/POPESTIMATE
keep if Year == 2020
drop rpp rpi PCE POPESTIMATE
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/real income per capita beginning of period.dta", replace

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
drop if Year == 2020
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS GeoName Year inf
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/real income per capita beginning of period.dta"
drop if _merge != 3
drop _merge
drop Year
drop if _n == 1 | _n == 2
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/beginning-of-period rpi_pop & post-covid infl.dta", replace

* Scatterplot showing the relationship between real beginning-of-period income per capita and post-COVID inflation rates
binscatter inf rpi_pop

