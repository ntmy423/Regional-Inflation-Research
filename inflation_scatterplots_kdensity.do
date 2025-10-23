/* Purpose: Creating scatterplot showing the relationship between pre- & post-COVID real personal income growth rate and inflation rates; Creating scatterplot showing the relationship between pre- & post-COVID nominal personal income growth rate and inflation rates; Creating scatterplot showing the relationship between pre- & post-COVID population growth rate and inflation rate; Creating a list of top CBSAs/GeoFIPS and bottom CBSAs/GeoFIPS in terms of inflation post-covid; Creating Kdensity plot showing the relationship between pre- and post-COVID annualized inflation rates

Last modified: MN, 03/24/2025 

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", clear

* Scatterplot showing the relationship between pre- & post-COVID real personal income growth rate and inflation rates
binscatter inf g_rpi_pop if Year == 2020
binscatter inf g_rpi_pop if Year == 2023

* Scatterplot showing the relationship between pre- & post-COVID nominal personal income growth rate and inflation rates
binscatter inf g_inc_pop if Year == 2020
binscatter inf g_inc_pop if Year == 2023

* Scatterplot showing the relationship between pre- & post-COVID population growth rate and inflation rate
binscatter inf g_pop if Year == 2020
binscatter inf g_pop if Year == 2023

* Find the outliers in the scatterplot showing the relationship between pre- & post-COVID real personal income growth rate and inflation rates
** High g_rpi_pop (above 10) & High inf (above 10.8) for the Year 2023
keep GeoFIPS GeoName Year g_rpi_pop inf
keep if Year == 2023
drop if missing(g_rpi_pop)
list GeoFIPS GeoName g_rpi_pop inf if g_rpi_pop > 10 & inf > 10.8

** Low g_rpi_pop (below -4) & High inf (above 10.8)
list GeoFIPS GeoName g_rpi_pop inf if g_rpi_pop < -4 & inf > 10.8


* List of top CBSAs/GeoFIPS and bottom CBSAs/GeoFIPS in terms of inflation post-covid
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_23.dta", clear
sort inf
list GeoFIPS GeoName inf in -5/l
list GeoFIPS GeoName inf in 1/5


* Kdensity plot showing the relationship between pre- and post-COVID annualized inflation rates
use "/Users/mynguyen/Documents/ECON 321 - Honors Project/PCE/inf_wide_20_23.dta", clear
twoway (kdensity inf2020, lcolor(blue) lpattern(solid)) (kdensity inf2023, lcolor(red) lpattern(solid)), title("Kernel Density of Annualized Inflation (Pre- vs Post-COVID)") xlabel(,grid) ylabel(,grid) legend(order(1 "Pre-COVID Inflation" 2 "Post-COVID Inflation"))


