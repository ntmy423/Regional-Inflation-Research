/* Purpose: Creating OLS regression showing the relationship between population growth rate, real personal income growth rate, and unemployment rate

Last modified: MN, 03/24/2025  

*/

use "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/inf_all_data.dta", clear
drop if Year == 2017
* Creates a dummy: 1 for post-COVID, 0 for pre-COVID
gen postcovid = (Year > 2020)  
* OLS Regression
reg inf g_pop g_rpi_pop u_rate postcovid, robust


