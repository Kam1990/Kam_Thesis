#This script loads the packages and constructs the data for the project:   
#It should be run once each time a user begins a new R session to work on the project.

#########################
#Load init functions
source("functions/init_functions.R")

#Loading and installing packages
init.pacs(c("tidyverse",      #shortcut to many useful packages (eg, dplyr, ggplot)
            "conflicted",     #resolves function conflict across packages
            "lubridate",      #working with dates
            "googledrive",    #for interacting with google drive as data repository
            "sf",             #for GIS
            "USAboundaries"   #easily access US maps in sf
            ))


#Setting package::function priority with conflicted package
conflict_prefer("filter", "dplyr")
conflict_prefer("between", "dplyr")
#########################
#Loading project helper functions (all scripts within folder)
run.script("functions")


##########################################
##########################################
#Function to download the project data (on first run, google should prompt you to login with credentials)
#if data folder doesn't exist, build data
get.data("")


folder.check.create()
#########################
#Load cached data if exists otherwise build data
#load.or.build()

