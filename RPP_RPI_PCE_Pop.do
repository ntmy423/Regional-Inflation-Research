/* Purpose: Merging pre- & post-COVID RPP data, Local RPI data, PCE data with population data

Last modified: MN, 03/24/2025  

*/

* Retain regional price parities data
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/MARPP_2008_2023_long.dta", clear
keep if LineCode == 1
drop Region TableName LineCode GeoName IndustryClassification Description Unit
rename rpp_ rpp
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/RPP_2008_2023.dta", replace
* Merge with Real personal income data
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPI_2008_2003.dta"
drop _merge
keep if Year == 2017 | Year == 2020 | Year == 2023
* Merge with PCE data
merge m:1 Year using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/PCE_2017_2023.dta"
drop _merge
sort GeoFIPS Year
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPP_RPI_PCE_17_23.dta", replace

* Merge with Population data
* Reshape population data
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_wide_2017_2023.dta", clear
rename CBSA GeoFIPS
drop NAME
reshape long POPESTIMATE, i(GeoFIPS) j(Year)
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_est_long_17_23.dta", replace
gen GeoFIPS_str = string(GeoFIPS, "%05.0f")
drop GeoFIPS
rename GeoFIPS_str GeoFIPS
gen GeoFIPS_new = substr(GeoFIPS, 1, 5)
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
describe GeoFIPS
order GeoFIPS Year POPESTIMATE
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_est_long_17_23_newGeoFIPS.dta", replace

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPP_RPI_PCE_17_23.dta", clear
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS Year rpp rpi PCE

merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_est_long_17_23_newGeoFIPS.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/RPP_RPI_PCE_Pop_17_23.dta", replace
