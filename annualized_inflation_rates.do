/* Purpose: Calculating pre- & post-COVID annualized ìnlation rate; Creating scatterplot showing the relationship between pre-COVID and post-COVID inflation rates; Creating Kdensity showing the relationship between pre-COVID and post-COVID inflation rates; Creating summarize table of pre- and post-COVID inflation rates showing mean, standard deviation, variance, median, 5th percentile, 95th percentile

Last modified: MN, 03/24/2025

*/

* Calculating the pre- & post-COVID annualized inflation rate using RPP and PCE
* Keeping data for relevant years
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Regional Price Parities Data/MARPP_2008_2023_long.dta", clear
keep if Year == 2017 | Year == 2020 | Year == 2023 
keep if LineCode == 1 
drop GeoName LineCode Industry Description Unit TableName Region
rename rpp_ rpp
* Merge with PCE data
merge m:1 Year using "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/PCE_2017_2023.dta"
drop _merge
sort GeoFIPS Year
gen Price = rpp * PCE 
bysort GeoFIPS (Year): gen inf = ((Price/Price[_n-1])^(1/3) - 1) * 100
drop if Year == 2017
drop rpp PCE Price
reshape wide inf, i(GeoFIPS) j(Year)
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/PCE Data/inf_wide_20_23.dta", replace


* Binscatter graph between pre-COVID and post-COVID inflation rates
binscatter inf2020 inf2023

* Kdensity pre-COVID inflation rates
kdensity inf2020
* Kdensity ppst-COVID inflation rates
kdensity inf2023


* Kdensity graph between pre-COVID and post-COVID inflation rates
twoway (kdensity inf2020, lcolor(blue) lpattern(solid)) (kdensity inf2023, lcolor(red) lpattern(twoway (kdensity inf2020, lcolor(blue) lpattern(solid)) (kdensity inf2023, lcolor(red) lpattern(solid)), title("Kernel Density of Annualized Inflation (Pre- vs Post-COVID)") xlabel(,grid) ylabel(,grid) legend(order(1 "Pre-COVID Inflation" 2 "Post-COVID Inflation"))


* Summarize table of pre- and post-COVID inflation rates
summarize inf2020 inf2023, detail



