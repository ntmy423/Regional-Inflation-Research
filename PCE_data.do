/* Purpose: Creating PCE dataset using data from FRED

Last modified: MN, 03/24/2025

*/

* Import average annual PCE from 2008 to 2023
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/PCE.xlsx", sheet("Annual") firstrow clear
gen Year = year(observation_date)
drop observation_date
order Year PCE
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/PCE_2008_2023.dta", replace

* Keep only PCE for 3 years (2017, 2020, 2023)
keep if Year == 2017 | Year == 2020 | Year == 2023
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/PCE_2017_2023.dta", replace
