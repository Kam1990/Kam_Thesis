# Init functions:
# These functions help to initialize the project without
# leaving artifacts in the workspace

#####################################################
#Loading and installing packages
init.pacs <- function(package.list){
  check <- unlist(lapply(package.list, require, character.only = TRUE))
  #Install if not in default library
  if(any(!check)){
    for(pac in package.list[!check]){
      install.packages(pac)
    }
    lapply(package.list, require, character.only = TRUE)
  }
}
#unit test
#init.pacs(c("scales"))


#####################################################
#Run all scripts in a directory
run.script <- function(dir.name){
  #check whether directory exists
  if(dir.exists(dir.name)){
    if(!is.null(dir(dir.name,pattern = ".R"))){
      invisible(lapply(dir(dir.name,pattern = ".R",full.names = T),source))
    }
  } else {
    stop("Invalid directory name")
  }
}
#unit test
#run.script("functions")

####################################################
#Load data from cache or build from munge script
#note that both inputs are strings that call files by name
load.or.build <- function(dataset,munge.script){
  if(file.exists(str_c("cache/",dataset))){
    message(str_c("Loading ",dataset," from cache"))
    load(str_c("cache/",dataset),envir = .GlobalEnv)
  } else {
    message(str_c("running ",munge.script," to build ",dataset))
    source(str_c("munge/",munge.script))
  }
}

####################################################
#Function to read project data from google drive
get.data <- function(folder_url){
  require(googledrive)
  if(dir.exists("data")){
    message("Data already exists in data folder.  Delete data folder and rerun build.R to download and rebuild the data.")
  } else {
    dir.create("data")
    message("The data folder has been created.")
    
    #Checking  for non-empty url -- eventually replace with proper trycatch in drive_get()  
    if(folder_url==""){
      break
    }
      
    #Locate zip files on google drive
    files <- drive_get(as_id(folder_url)) %>% 
      drive_ls() %>%
      filter(str_detect(name,pattern = "zip"))
    
    #Loop over list of zip files; write to data folder; unzip; and delete zipped folder
    message("The zipped file with raw data is large.  It may take a little while - but it only happens once.")
    map2(.x = files$id,
         .y = files$name, 
         function(x,y){
           #Download files from googledrive folder
           drive_download(as_id(x),path = str_c("data/",y),overwrite = T)
           
           #Unzip files
           unzip(zipfile = str_c("data/",y),
                 exdir = "data",
                 overwrite = T)
           
           #Remove the zipped file
           file.remove(str_c("data/",y))
           
         })
    
  }
  
  
  
}


######################################3

folder.check.create <- 
  function(folder=c("cache","figures","tables")){
    map(folder,
        function(x){
          if(!dir.exists(x)){
            dir.create(x)
            message(str_c("The ",x," folder has been created."))
          }
        }
    )
  }


