/*Purpose: Creating Regional Price Parities (RPP) dataset using RPP (from 2008 to 2023) from BEA website & Reshape the RPP dataset from wide to long version 

Last modified: MN, 03/24/2025
*/

import excel "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Regional Price Parities Data/MARPP_MSA_2008_2023.xlsx", sheet("MARPP_MSA_2008_2023") firstrow clear


rename I rpp_2008

rename J rpp_2009

rename K rpp_2010

rename L rpp_2011

rename M rpp_2012

rename N rpp_2013

rename O rpp_2014

rename P rpp_2015

rename Q rpp_2016

rename R rpp_2017

rename S rpp_2018

rename T rpp_2019

rename U rpp_2020

rename V rpp_2021

rename W rpp_2022

rename X rpp_2023

duplicates report GeoFIPS Region TableName LineCode
describe rpp_*
destring rpp_*, replace force

*Reshape to long version
reshape long rpp_, i(GeoFIPS Region TableName LineCode) j(Year)

save "/Users/mynguyen/Documents/ECON 321 - Honors Project/Data/Regional Price Parities Data/MARPP_2008_2023_long.dta", replace
