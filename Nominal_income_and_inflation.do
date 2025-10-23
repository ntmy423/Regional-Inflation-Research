/* Purpose: Creating pre- & post-COVID Local Nominal Income dataset using data from BEA; Merging nominal beginning-of-period income with post-COVID inflation rates; Scatterplot showing the relationship between nominal beginning-of-period income and post-COVID inflation rates

Last modified: MN, 03/24/2025

*/

import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/Nominal income.xlsx", sheet("Table") firstrow clear
drop F
rename C inc2017
rename D inc2020
rename E inc2023
duplicates list
duplicates drop
drop if _n == 386
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal_inc_17_23.dta", replace
reshape long inc, i(GeoFips GeoName) j(Year)
sort GeoFips GeoName Year
rename GeoFips GeoFIPS
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal inc_17_23_long.dta", replace

* Calculate nominal income growth
bys GeoFIPS (Year): gen g_inc = ((inc/inc[_n-1])^(1/3) - 1) * 100
drop if Year == 2017
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/inc growth_17_23.dta", replace

* Merge nominal income growth and inflation rates
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS GeoName Year inf
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/inc growth_17_23.dta"
drop if _merge != 3
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/g_inc&inf_20_23.dta", replace

* Merge nominal beginning-of-period income with post-COVID inflation rates
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal inc_17_23_long.dta", clear
drop if Year == 2017
drop if Year == 2023
drop if _n == 1
rename GeoFips GeoFIPS
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal beginning-of-period income.dta", replace
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS GeoName Year inf
drop if Year == 2020
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal beginning-of-period income.dta"
drop if _merge != 3
drop _merge
drop Year
gen log_inc = log(inc)
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal beginning-of-period inc & inf (post-covid).dta", replace

* Scatterplot showing the relationship between nominal beginning-of-period income and post-COVID inflation rates
binscatter inf log_inc

