/* Purpose: Master Replication File

Last modified: MN, 03/24/2025 

*/

clear all

global root "/Users/ak3386/Library/CloudStorage/OneDrive-DrexelUniversity/Data/RAwork/BEA_regional_inflation/ECON321_Honors_Project"

cap log close
cap set scheme cleanplots

* Creating Regional Price Parities (RPP) dataset using RPP (from 2008 to 2023) from BEA website & Reshape the RPP dataset from wide to long version 
do $root/Code/RPP_Code/RPP_dataset.do

* Calculating inflation rates of regional price parities; Creating scatterplot showing the relationship between pre- & post-COVID inflation rates of regional price parities
do $root/Code/RPP_Code/rpp_inflation_rate.do

* Creating PCE dataset using dataset from FRED
do $root/Code/PCE_Code/PCE_data.do

* Calculating pre- & post-COVID annualized ìnlation rate; Creating scatterplot showing the relationship between pre-COVID and post-COVID inflation rates; Creating Kdensity showing the relationship between pre-COVID and post-COVID inflation rates; Creating summarize table of pre- and post-COVID inflation rates showing mean, standard deviation, variance, median, 5th percentile, 95th percentile
do $root/Code/Inflation_Code/annualized_inflation_rates.do

* Creating Local Real Personal Income (RPI) dataset using Local RPI (from 2008 to 2023) from BEA website & Reshape the Local RPI dataset from wide to long version; Calculating real personal income growth rate 
do $root/Code/Local_RPI_Code/Local_Real_Personal_Income_data.do

* Creating local population dataset using population estimation data based on MSAs from Census; Merging pre- & post-COVID population data; Calculating pre- & post-COVID population growth rate
do $root/Code/Population_Code/Population_growth.do

* Creating pre-COVID and post-COVID unemployment rates dataset using unemployment rate data from BLS
do $root/Code/Unemployment_Rate_Code/Pre_Post_COVID_u_rate.do

* Creating pre- & post-COVID Local Nominal Income dataset using data from BEA; Merging nominal beginning-of-period income with post-COVID inflation rates; Scatterplot showing the relationship between nominal beginning-of-period income and post-COVID inflation rates
do $root/Code/Local_Nominal_Income_Code/Nominal_income_and_inflation.do

* Merging pre- & post-COVID inflation rates data with population growth rates data
do $root/Code/Population_Code/Infl_&_pop_growth.do

* Merging population growth rate and inflation data with local real personal income data
do $root/Code/Local_RPI_Code/pop_growth_&_inflation_&_local_real_personal_income.do

* Merging pre- & post-COVID RPP data, Local RPI data, PCE data with population data
do $root/Code/Population_Code/RPP_RPI_PCE_Pop.do

* Merging local real beginning-of-period income with post-COVID inflation rates data; Creating scatterplot showing the relationship between local real beginning-of-period income and post-COVID inflation rates
do $root/Code/Local_RPI_Code/real_beginning_of_period_income_&_post_covid_inflation.do

* Merging local real beginning-of-period income per capita with post-COVID inflation rates data; Creating scatterplot showing the relationship between local real beginning-of-period income per capita and post-COVID inflation rates
do $root/Code/Local_RPI_Code/real_beginning_of_period_income_per_capita_&_post_covid_inflation.do

* Merging nominal beginning-of-period income per capita and post-COVID inflation; Creating scatterplot showing the relationship between nominal beginning-of-period income per capita and post-COVID inflation
do $root/Code/Local_Nominal_Income_Code/nominal_beginning_of_period_income_per_capita_and_post_covid_inflation.do

* Merging pre-COVID and post-COVID inlfation data and unemployment rate data
do $root/Code/Unemployment_Rate_Code/inflation_and_unemployment_rate.do

* Calculating real income per capita, growth rate of real income per capita, natural logarithm of real personal income, regional price parities inflation rates, Price inflation rates; Then, merging all the variables into one complete data set
do $root/Code/dataset_with_all_variables.do

* Creating scatterplot showing the relationship between pre- & post-COVID real personal income growth rate and inflation rates; Creating scatterplot showing the relationship between pre- & post-COVID nominal personal income growth rate and inflation rates; Creating scatterplot showing the relationship between pre- & post-COVID population growth rate and inflation rate; Creating a list of top CBSAs/GeoFIPS and bottom CBSAs/GeoFIPS in terms of inflation post-covid; Creating Kdensity plot showing the relationship between pre- and post-COVID annualized inflation rates
do $root/Code/Inflation_Code/inflation_scatterplots_kdensity.do







