/* Purpose: Creating Local Real Personal Income (RPI) dataset using Local RPI (from 2008 to 2023) from BEA website & Reshape the Local RPI dataset from wide to long version; Calculating real personal income growth rate

Last modified: MN, 03/24/2025  

*/

* Import local real personal income data
import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/MARPI_MSA_2008_2023.xlsx", sheet("MARPI_MSA_2008_2023") firstrow clear

rename I rpi_2008

rename J rpi_2009

rename K rpi_2010

rename L rpi_2011

rename M rpi_2012

rename N rpi_2013

rename O rpi_2014

rename P rpi_2015

rename Q rpi_2016

rename R rpi_2017

rename S rpi_2018

rename T rpi_2019

rename U rpi_2020

rename V rpi_2021

rename W rpi_2022

rename X rpi_2023

duplicates report GeoFIPS Region TableName LineCode

describe rpi_*

destring rpi_*, replace force

reshape long rpi_, i(GeoFIPS Region TableName LineCode) j(Year)

keep if LineCode == 1

drop GeoName IndustryClassification Region TableName Unit LineCode Description

rename rpi_ rpi

save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPI_2008_2003.dta", replace

keep if Year == 2017 | Year == 2020 | Year == 2023

* Calculating real personal income growth rate
bys GeoFIPS (Year): gen g_rpi = ((rpi/rpi[_n-1])^(1/3) - 1) * 100
drop if Year == 2017
drop rpi
replace GeoFIPS = trim(GeoFIPS)
gen GeoFIPS_new = substr(GeoFIPS, 2, 5) 
drop GeoFIPS
rename GeoFIPS_new GeoFIPS
order GeoFIPS Year g_rpi
save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Local Real Income Data/RPI_infl_17_23.dta", replace




