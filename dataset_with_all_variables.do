/* Purpose: Calculating real income per capita, growth rate of real income per capita, natural logarithm of real personal income, regional price parities inflation rates, Price inflation rates; Then, merging all the variables into one complete data set

Last modified: MN, 03/24/2025  

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/RPP_RPI_PCE_Pop_17_23.dta", clear
gen rpi_pop = rpi/POPESTIMATE
gen log_rpi = log(rpi)
bys GeoFIPS (Year): gen g_rpi_pop = ((rpi_pop/rpi_pop[_n-1])^(1/3) - 1) * 100

merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/pop_growth_inf_rpi.dta"
drop _merge

bys GeoFIPS (Year): gen rpp_inf = ((rpp/rpp[_n-1])^(1/3) - 1) * 100
rename POPESTIMATE pop
rename pop_growth g_pop
drop inf
gen Price = rpp * PCE 
bysort GeoFIPS (Year): gen inf = ((Price/Price[_n-1])^(1/3) - 1) * 100
** Merge GeoName
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_17_23.dta"
drop _merge
order GeoFIPS GeoName Year rpp rpp_inf PCE Price inf pop g_pop rpi log_rpi g_rpi rpi_pop g_rpi_pop
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", replace 

** Merge unemployment rate
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_inf_merge.dta", clear
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS GeoName Year inf u_rate
drop inf
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_20_23.dta", replace
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", clear 
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_20_23.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", replace

** Merge & calculating nominal income, nominal income per capita, and natural logarithm of nominal income
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", clear
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Nominal Income Data/nominal inc_17_23_long.dta"
drop _merge
gen inc_pop = inc/pop
gen g_inc_pop = ((inc_pop/inc_pop[_n-1])^(1/3) - 1) * 100
gen log_inc = log(inc)
order GeoFIPS GeoName Year rpp rpp_inf PCE Price inf pop g_pop rpi log_rpi g_rpi rpi_pop g_rpi_pop u_rate inc log_inc inc_pop g_inc_pop
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", replace 

