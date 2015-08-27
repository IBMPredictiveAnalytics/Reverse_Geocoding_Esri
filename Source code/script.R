
# Install function for packages (automatic)
packages <- function(x){
  x <- as.character(match.call()[[2]])
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x,repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}

packages(RCurl)
packages(RJSONIO)
packages(plyr)

latitude <- modelerData$%%lat%%
  longitude<-modelerData$%%lon%%
  token<-'%%token%%'
print(location)
root <- "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/reverseGeocode"
u <- paste(root,  "?location=",lat,'%2C+',lon,'&distance=200&outSR=', "&token=", token, "&f=json", sep = "")
u <- gsub(' ','%20',u) #Encode URL Parameters
print(u)

doc <- aaply(u,1,getURL)
json <- alply(doc,1,fromJSON,simplify = FALSE)
coord = laply(json,function(x) {
  
  lat <- x$locations[[1]]$feature$geometry$x
  lng <- x$locations[[1]]$feature$geometry$y
  return(c(lat,lng))
  
})
lng<-c(coord[,1])
lat<-c(coord[,2])
modelerData<-cbind(modelerData,lat)
print(modelerData)
var1<-c(fieldName="Latitude",fieldLabel="",fieldStorage="real",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var1)
modelerData<-cbind(modelerData,lng)
print(modelerData)
var2<-c(fieldName="Longitude",fieldLabel="",fieldStorage="real",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var2)

