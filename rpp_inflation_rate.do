/* Purpose: Calculating inflation rates of regional price parities; Creating scatterplot showing the relationship between pre- & post-COVID inflation rates of regional price parities

Last modified: MN, 03/24/2025 

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Regional Price Parities Data/MARPP_2008_2023_long.dta", clear

* Keeping data for relevant years
keep if Year == 2017 | Year == 2020 | Year == 2023 
keep if LineCode == 1 
drop GeoName LineCode IndustryClassification Description Unit TableName Region
rename rpp_ rpp

* Calculate annualized inflation rate between 2017-2020 and 2020-2023
bys GeoFIPS (Year): gen rpp_infl = ((rpp/rpp[_n-1])^(1/3) - 1) * 100
drop if Year == 2017
drop rpp
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Regional Price Parities Data/rpp_inf_long_17_23.dta", replace

* Reshape the dataset to wide version
reshape wide rpp_infl, i(GeoFIPS) j(Year)

* Binscatter graph between pre- & post-COVID inflation rates of regional price parities
binscatter rpp_infl2020 rpp_infl2023

