# Kam Thesis

This repository corresponds to Kamrul Hassan's thesis project: *title here*.  The project investigates the impact of flooding on rice production in Bangladesh. 

this is test line.


# Project Structure
This section describes the folder structure of the project and logic of the scripts that compile and analyze the data.  All file references within project are relative to the root directory of the project.         

- The project `data` is stored in the data folder.  The raw data should be placed into this folder and never modified.  *For example, place the river gauge level data file in this folder.*     

- The `munge` folder contains all scripts to read in and process the raw data into a form suitable for analysis.  *For example, this folder should contain the script that reads in the river gauge level data from each gauge and constructs the danger days variable.*   

- The `cache` folder stores intermediate datasets created throughout the project.  In general, each munge script should generate an intermediate dataset that is cached to this folder.  The cache folder should also contain the dataset used for analysis.  *For example, this folder should contain the dataset with danger days at the district year level that can be merged with the rice production data.*

- The `analysis` folder contains all scripts that analyze data.  These scripts may run regressions that output results into tables and/or generate figures.

- The `figures` folder is a repository for images produced by the analysis scripts.

- The `tables` folder is a repository for tables produced by the analysis scripts.   

- The `report` folder contains the write up of the project and may contain a link to a collaborative writing site.  

- The `functions` folder contains functions called within the project.


The script `build.R` located in the root folder loads packages, defines global variables and defines the logic of the project.  After loading all packages called within the project, resolving conflicts, and defining global variables, the script downloads the raw data (if it does not yet exist) and runs the munge scripts to build the dataset (the order is defined by a sequence of load.or.build function calls).  Any component of the dataset can be rebuilt by deleting a cached dataset from the cache folder.  

**Run the build.R script first each time you open the project to ensure reproducibility.**



**************

