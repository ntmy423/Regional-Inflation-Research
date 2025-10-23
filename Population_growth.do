/* Purpose: Creating local population dataset using population estimation data based on MSAs from Census; Merging pre- & post-COVID population data; Calculating pre- & post-COVID population growth rate

Last modified: MN, 03/24/2025  

*/

* Import CBSA data for population estimation in 2017 and 2020
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/cbsa-est2020-alldata.xlsx", sheet("cbsa-est2020-alldata") firstrow clear
keep if LSAD == "Metropolitan Statistical Area"
drop POPESTIMATE2020
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2017.dta", replace

* Import CBSA data for population estimation in 2020 and 2023
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/cbsa-est2023-alldata.xlsx", sheet("cbsa-est2023-alldata") firstrow clear
keep if LSAD == "Metropolitan Statistical Area"
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2023.dta", replace

* Merge two data sets (CBSA data for population estimation in 2017, 2020, and 2023)
merge 1:1 CBSA using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2017.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2017_2023.dta", replace

import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/cbsa-est2020-alldata.xlsx", sheet("cbsa-est2020-alldata") firstrow clear
keep if LSAD == "Metropolitan Statistical Area"
drop POPESTIMATE2017
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2020.dta", replace
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2017_2023.dta", clear
drop POPESTIMATE2020
merge 1:1 CBSA using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_2020.dta"
drop _merge
drop LSAD
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_wide_2017_2023.dta", replace

* Reshape the population data set from wide to long version
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CBSA_pop_est_wide_2017_2023.dta", clear
reshape long POPESTIMATE, i(CBSA NAME) j(Year)
rename POPESTIMATE pop
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/CSBA_pop_17_23_long.dta", replace

* Calculating pre- & post-COVID population growth rate
bys CBSA (Year): gen pop_growth = ((pop/pop[_n-1])^(1/3) - 1) * 100
drop if Year == 2017
drop pop NAME
rename CBSA GeoFIPS
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Population Data/pop_growth_long_20_23.dta", replace


