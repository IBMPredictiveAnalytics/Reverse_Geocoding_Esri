# Reverse Geocoding: Get the address that corresponds to a given latitude and a given longitude 
# Node Developed by IBM

# Packages used : 
# 'plyr' author : Hadley Wickham
#	'RCurl' author : Duncan Temple Lang 
# 'RJSONIO' author : Duncan Temple Lang         

# Install packages if necessary

if (require("plyr")) {
  print("plyr is loaded correctly")
} else {
  print("trying to install plyr")
  install.packages("plyr")
  if (require(plyr)) {
    print("plyr installed and loaded")
  } else {
    stop("Could not install required packages (plyr)")
  }
}
library(plyr)

if (require("RCurl")) {
  print("RCurl is loaded correctly")
} else {
  print("trying to install RCurl")
  install.packages("RCurl")
  if (require(RCurl)) {
    print("RCurl installed and loaded")
  } else {
    stop("Could not install required packages (RCurl)")
  }
}
library(RCurl)  

if (require("RJSONIO")) {
  print("RJSONIO is loaded correctly")
} else {
  print("trying to install RJSONIO")
  install.packages("RJSONIO")
  if (require(RJSONIO)) {
    print("RJSONIO installed and loaded")
  } else {
    stop("Could not install required packages (RJSONIO)")
  }
}
library(RJSONIO) 
library(httr)
#Generate Token
pwd <- '%%pwd%%'
url = "https://arcgis.com/sharing/rest/generateToken"
data = list('username'= "%%username%%",
            'password'= pwd,
            'referer' = 'http://arcgis.com',
            'expiration' = 1209600,
            'f'= 'json')
r<-POST(url,body = data)
content(r)
x <- fromJSON(content(r))
token<-x$token

# forming URL address
lat <- modelerData$%%identif_lat%%
  long<-modelerData$%%identif_lng%%
  
  root <- "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/reverseGeocode"
url <- paste(root,  "?location=",long,'%2C+',lat,'&distance=', %%dist%%,'&outSR=', "&token=", token, "&f=json", sep = "")

print(url)

# This function takes a URL list and returns a dataframe with lat long and status
getAddress <- function(url) {
  # performing GET on url
  doc <- llply(url, getURL)
  # converting jso into list
  json <- llply(doc, fromJSON, simplify = FALSE)
  # Getting lat and long fields from the json object
  coord = ldply(json, function(x) {
    
    Address<-x$address$Address
    Neighborhood<-x$address$Neighborhood
    City<-x$address$City
    Subregion<-x$address$Subregion
    Region<-x$address$Region
    Postal<-x$address$Postal
    PostalExt<-x$address$PostalExt
    CountryCode<-x$address$CountryCode
    Match_addr<-x$address$Match_addr
    
    Address[is.null(Address)] <- "empty"
    Neighborhood[is.null(Neighborhood)] <- "empty"
    City[is.null(City)] <- "empty"
    Subregion[is.null(Subregion)] <- "empty"
    Region[is.null(Region)] <- "empty"
    Postal[is.null(Postal)] <- "empty"
    PostalExt[is.null(PostalExt)] <- "empty"
    CountryCode[is.null(CountryCode)] <- "empty"
    Match_addr[is.null(Match_addr)] <- "empty"
    
    return(c(Address, Neighborhood, City, Subregion, Region, Postal, PostalExt, CountryCode, Match_addr))
    
  }
  )
  return(coord)
}

coord <- getAddress(url)

Address<-c(coord[,1])
Neighborhood<-c(coord[,2])
City<-c(coord[,3])
Subregion<-c(coord[,4])
Region<-c(coord[,5])
Postal<-c(coord[,6])
PostalExt<-c(coord[,7])
CountryCode<-c(coord[,8])
Match_addr<-c(coord[,9])


modelerData<-cbind(modelerData,Address)
var1<-c(fieldName="Address",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var1)

modelerData<-cbind(modelerData,Neighborhood)
var2<-c(fieldName="Neighborhood",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var2)

modelerData<-cbind(modelerData,City)
var3<-c(fieldName="City",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var3)

modelerData<-cbind(modelerData,Subregion)
var4<-c(fieldName="Subregion",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var4)

modelerData<-cbind(modelerData,Region)
var5<-c(fieldName="Region",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var5)

modelerData<-cbind(modelerData,Postal)
var6<-c(fieldName="Postal",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var6)

modelerData<-cbind(modelerData,PostalExt)
var7<-c(fieldName="PostalExt",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var7)

modelerData<-cbind(modelerData,CountryCode)
var8<-c(fieldName="CountryCode",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var8)

modelerData<-cbind(modelerData,Match_addr)
var9<-c(fieldName="Match_addr",fieldLabel="",fieldStorage="string",fieldFormat="",fieldMeasure="",  fieldRole="")
modelerDataModel<-data.frame(modelerDataModel,var9)
