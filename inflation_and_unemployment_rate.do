/*Purpose: Merging pre-COVID and post-COVID inlfation data and unemployment rate data

Last modified: MN, 3/24/2025

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_20_23_long.dta", clear
replace GeoName = subinstr(GeoName, "-", " ", .)
gen first_three_words = word(GeoName, 1) + " " + word(GeoName, 2) + " " + word(GeoName, 3)
replace first_three_words = trim(first_three_words)
replace first_three_words = lower(first_three_words)
rename year Year
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_20_23_long_1st3words.dta", replace

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
replace GeoName = subinstr(GeoName, " (Metropolitan Statistical Area)", "", .)
replace GeoName = subinstr(GeoName, "-", " ", .)
gen first_three_words = word(GeoName, 1) + " " + word(GeoName, 2) + " " + word(GeoName, 3)
replace first_three_words = trim(first_three_words)
replace first_three_words = lower(first_three_words)
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23_1st3words.dta", replace

merge m:1 first_three_words Year using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23_1st3words.dta"
drop if _merge != 3
drop _merge
drop first_three_words
order GeoFIPS GeoName Year inf u_rate
binscatter u_rate inf if Year == 2023
binscatter u_rate inf if Year == 2020
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Unemployment Rate Data/U_rate_inf_merge.dta", replace
