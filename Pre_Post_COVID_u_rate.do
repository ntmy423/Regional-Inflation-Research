/* Purpose: Creating pre-COVID and post-COVID unemployment rates dataset using unemployment rate data from BLS

Last modified: MN, 03/24/2025  

*/

* 2017 MSA unemployment rate data
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2017_MSA_unemployment rate.xlsx", sheet("Sheet1") firstrow clear
describe
duplicates report MSA
duplicates list MSA
duplicates drop MSA, force
rename MSA Metropolitanarea
rename rate u_rate_17
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2017_MSA_u_rate.dta", replace

* 2020 MSA unemployment rate data
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2020_MSA_unemployment rate.xlsx", sheet("Sheet1") firstrow clear
describe
duplicates report Metropolitanarea
duplicates list Metropolitanarea
replace Metropolitanarea = subinstr(Metropolitanarea, "Metropolitan Statistical Area", "", .)
drop Rank
rename rate u_rate_20
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2020_MSA_u_rate.dta", replace

* 2023 MSA unrmployment rate data
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2023_MSA_unemployment rate.xlsx", sheet("Sheet1") firstrow clear
describe
duplicates report Metropolitanarea
duplicates list Metropolitanarea
replace Metropolitanarea = subinstr(Metropolitanarea, "Metropolitan Statistical Area", "", .)
drop Rank
rename rate u_rate_23
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2023_MSA_u_rate.dta", replace

* Merge 2020 and 2023 unemployment rate
merge m:m Metropolitanarea using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/2023_MSA_u_rate.dta"
drop _merge
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/20_23_MSA_u_rate.dta", replace
