---
title: "Austrlia Resource Projects Data Explorer"
author: "Bhaskar Bandaru"
date: "25th October 2015"
output: html_document
---
## Welcome to Austrlia Resource Projects Data Explorer

### Introduction

This Shiny application has been developed as part of the Data Products Development coursework conducted by John Hopkins Bloomberg School of Public Health Data Science course series organised by Coursera MOOC.

This application is based on Australian Resource Projects budget for Year 2014 to upto Year 2021. This covers the current/ongoing Resource sector projects and the future feasibility study and Comiited Resource sector projects in Australia.

Dataset has been obtained from the Australian Goverment web site [data.gov.au](http://data.gov.au/) and acoordding to this web site and as per the Australian Gocernment policies these data sets are available under creative common licenses and the details can be viewed from here [Creative Commons Attribution 3.0 Australia](http://creativecommons.org/licenses/by/3.0/au/) and these details can be viewed at [data.gov.au](http://data.gov.au/) for any further details. This web site does contain rich set of data bases which are open for public domain review, and usage.

This application promotion details aslo available on RPubs as the presentation material.

Source code is available on the [GitHub](https://github.com/bbandaru/Coursera_Data_Products_Shiny).


### Application Overview

##### Australia Resource Projects Data Explorer

The Shiny applicaiton is developed to have a Visualisation of Ausrtralia Resource Projects Data. 
The Application provides both the visual desription and facility to view the data in detail and also to download a file related to the selected Resource sector industry. 

This App provides the Australia Resource Projects in Resoure Sector from Year 2014 to 2021.  

The Data visulation provides the facility to visualise the number of projects and the amount of investment,costs and the budget involved accross Australia in all major states. 

The application provides the interactive way to explore and visualisation of the data per each Resource Sector per year per state/province and type of project and the status of the project and the budgets involved in Australin Dollar. 

The application provides the visulation in different layers/tabs so that uer can explore that data per each state or visually based on the GIS data per region across Australia and per year wise analysis. 

The application developed to show case the different visulation features (rCharts, googleVis and ggplot2 techniques).

### Data Overview


The data for this anaylis is obtained from the [data.gov.au/dataset](http://data.gov.au/dataset) repository. 
The data has been provided in multiple pages /tabs in Microsfot 2013  Excels file format. The actual URL for the source of the data set is [here](http://www.data.gov.au/dataset/resources-and-energy-major-projects).


The data from this excel sheets has been extracted using the "R" packages and the tidy data file in csv format has been developed using the r code. 

The original excel file also has been stored in the data repository at [Github](https://github.com/bbandaru/Coursera_Data_Products_Shiny) web site.

The R code for the data cleaning has not been included. However the key steps and the pipe line of activities have been described in this section. 

* 1) Most of the data is derived from the consolidated data sheet (last tab) in the original Excel downloaded file. 
* 2) The resource sectors are very much detailed our in the last consolidated data sheet. However these detail resource sectors are grouped using the aggregated resoruce sector inforamtion available from other tabs and the roll-up has been done to get aggregated and simple view to follow the major resource sector investments and project activities.
* 3) The original data sheet provides detail location and phyiscal address of each project and these data has been dropped and only focused at the state/province level by aggegating the data per state.
* 4) For couple of cases where the State information is not provided those cells are corrected with appropriate state based on the detail location information of the project. Though the updates are done using the R code the identification of these things has been done as individual steps ratrher than a pipeline flow of activity.
* 5) For the future and potential budgets where a min to max range is provided for all those cases the max range has been considered.
* 6) GoogleVis package is used to generated the geo map visualisation however when we need to use this package the states are identified wtih prefix "AU-" infront of the state abbreviations (for example NSW would be AU-NSW) and this notation is followd in this analysis and the data has been modified accordingly.
* 7) The tidy data has been provided as 'AUProjects.csv' file in the data repository. 

##### Key data Fields

--  [1] "SECTOR"  - Identifcation of Resouce Sector group and this has the following ddata
                  --- "aluminium, alumina, bauxite"  ,  "coal"              , "copper"
                      "gold"                         ,  "infrastructure"    , "iron ore"                    
                      "lead, zinc, silver"           ,  "lng, gas, oil"     , "nickel"                                                     "other commodities"            , "uranium" 
--  [2] "STATE"   - Identification of the Australian State 
                  --- "AU-NSW" "AU-NT"  "AU-QLD" "AU-SA"  "AU-TAS" "AU-VIC" "AU-WA" 
                  
--  [3] "YEAR"    - Project years from 2014 to 20121 (either start or finish or feasibility study and or expected completion ..etc..)

--  [4] "TYPE"    - Project TYPE - such as "EXPANSION"     "EXTENSION"     "NEW PROJECT"   "REDEVELOPMENT"


--  [5] "STATUS"  - Project STATUS  - such as "Announced"   "Committed"   "Completed"   "Feasibility"

--  [6] "COST"    - Project Costs in Australian Dollar either already spent, and forecasted and/or estimate or budget



### User Guide

The application is mostly interactive and intutive from user perspective.

-- The use has the option to adjust  range and event types using control panel located on the left side.

-- User has the option to check different Resource sectors to identify the resource sector group of their choice. 
   
   The output and data visualtion is provided on various data tab options state level aggregatkon bar grophs, Geo map visulation of the state and the 3rd tab provides the data per year, the final tab provides the detail data table.
   
-- The dataset can be downloaded using data tab.

### Conclusions

The data visulation show cleearly the major investments and spends are done in Western Australia (AU-WA) and Queensland (AU-QLD). 

In general this is expected but however it would be clear visibility for others (who are not directly living in Australia or has a less knowledge of Australian geography).

This visulation also presents clear interaction view for each state and the major investments and committment for the economic growth and the potential future employment opportunity.

#### Thank you very much fro your interest in this application.



