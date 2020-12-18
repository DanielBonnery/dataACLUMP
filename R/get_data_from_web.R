get_data_from_web<-function(directory=NULL){
  if(is.null(directory)){
    directory<-file.path(find.package("dataACLUMP"),'inst','extdata')
    datadirectory<-file.path(find.package("dataACLUMP"),'data')
  }else{datadirectory<-directory}
  if(!file.exists(directory)){
    dir.create(directory,recursive = T)
  }
  if(!file.exists(datadirectory)){
    dir.create(datadirectory,recursive = T)
  }
  zipped.files.to.download.urls<-c(
    "https://www.agriculture.gov.au/sites/default/files/abares/aclump/documents/clum_data_2018/shapefile_currency_clum_50m1218m.zip",
    "https://data.gov.au/dataset/d897e165-46a3-4f3b-a2f2-b348ac06ddfe/resource/f76898c3-03f2-4780-afa8-b3b6863b1233/download/wa_clum_august-2018.zip",
    "https://www.agriculture.gov.au/sites/default/files/documents/clum_commodities_2018_v2.zip"
  )
  get_data_from_webs<-function(data.url){
    tmpd  <-tempdir()
    downloader::download(url=data.url,destfile = file.path(directory,basename(data.url)))}
  lapply(zipped.files.to.download.urls,get_data_from_webs)
  extract_CLUM_Commodities_2018_v2()
  #extract_shapefile_currency_clum_50m1218m()
  #extract_wa_clum_august2018()
}


extract_shapefile_currency_clum_50m1218m<-
  function(zipfilepath=file.path(find.package("dataACLUMP"),'inst','extdata','shapefile_currency_clum_50m1218m.zip'),
           destfile=file.path(find.package("dataACLUMP"),'data','state_currency_and_scale_December2018.rda')){
  unzip(zipfilepath,exdir = tempdir())
  state_currency_and_scale_December2018<-rgdal::readOGR(file.path(tempdir(),"shapefile_currency_clum_50m1218m","state_currency_and_scale_December2018.shp"))
  
}



extract_DP_QLD_LANDUSE_June_2019<-
  function(zipfilepath=file.path(find.package("dataACLUMP"),'inst','extdata','DP_QLD_LANDUSE_June_2019.zip'),
           destfile=file.path(find.package("dataACLUMP"),'data','QLD_LANDUSE_June_2019.rda')){
    unzip(zipfilepath,exdir = tempdir())
    y<-file.path(tempdir(),"QLD_LANDUSE_June_2019/QLD_LANDUSE_June_2019.gdb")
    #ogrListLayers(y)
    #rgdal::ogrInfo(y, layer =  "QLD_LANDUSE_CURRENT_X",require_geomType="wkbPolygon")
    QLD_LANDUSE_June_2019 <- readOGR(dsn = y,layer = "QLD_LANDUSE_CURRENT_X" ,require_geomType="wkbPolygon",drop_unsupported_fields = T,dropNULLGeometries = T)
    save(QLD_LANDUSE_June_2019,file=destfile)
  }


extract_CLUM_Commodities_2018_v2<-
  function(zipfilepath=file.path(find.package("dataACLUMP"),'inst','extdata','clum_commodities_2018_v2.zip'),
           destfile=file.path(find.package("dataACLUMP"),'data','CLUM_Commodities_2018_v2.rda')){
    unzip(zipfilepath,exdir = tempdir())
    #CLUM_Commodities_2018_v2<-sf::read_sf(file.path(tempdir(),"Spatial_data_zip","CLUM_Commodities_2018_v2.shp"))
    CLUM_Commodities_2018_v2<-rgdal::readOGR(file.path(tempdir(),"Spatial_data_zip","CLUM_Commodities_2018_v2.shp"))
    save(CLUM_Commodities_2018_v2,file=destfile)
  }

extract_wa_clum_august2018<-
  function(zipfilepath=file.path(find.package("dataACLUMP"),'inst','extdata','wa_clum_august-2018.zip'),
           destfile=file.path(find.package("dataACLUMP"),'data','wa_clum_august2018.rda')){
    unzip(zipfilepath,exdir = tempdir())
    
    y=file.path(tempdir(),"Spatial_data_zip","WA_Landuse_August2018.gdb")
    ogrListLayers(y)
    ql <- readOGR(dsn = y,layer = "QLD_LANDUSE_CURRENT_X" ,require_geomType="wkbPolygon",drop_unsupported_fields = T,dropNULLGeometries = T)
    
    
    wa_clum_august2018<-rgdal::readOGR(file.path(tempdir(),"Spatial_data_zip","WA_Landuse_August2018.gdb"))
    
    
    
    
    ogrListLayers(y)
    
    rgdal::ogrInfo(y, layer =  "QLD_LANDUSE_CURRENT_X",require_geomType="wkbPolygon")
    save(wa_clum_august2018,file=destfile)
  }

