.onLoad<- function(libname, pkgname) {
  if(length(list.files(file.path(try(find.package("dataACLUMP")),'inst','extdata')))==0){
    packageStartupMessage(
      paste0(
"
###########################################################
# This is the first time the package dataACLUPMles is loaded. #
# Or all the data has not been downloaded yet.            #
<<<<<<< HEAD
# Large zipped files will be downloaded to                #
# ",
file.path(find.package("dataACLUMP"),'inst','extdata'),
"
# A connection to the web is needed.                      #
# This takes a long time (less than 10 minutes though).   #
###########################################################
"))
get_data_from_web()
}}