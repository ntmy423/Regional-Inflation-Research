/* Purpose: Merging local real beginning-of-period income with post-COVID inflation rates data; Creating scatterplot showing the relationship between local real beginning-of-period income and post-COVID inflation rates

Last modified: MN, 03/24/2025

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/GeoName_inf_20_23.dta", clear
drop if Year == 2020
merge m:m GeoFIPS using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPI_beginning-of-period.dta"
drop _merge
gen log_rpi = log(rpi)
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/beginning-of-period rpi & post-covid inf.dta", replace

* Scatterplot showing the relationship between real beginning-of-period income and post-COVID inflation rates
binscatter inf log_rpi
