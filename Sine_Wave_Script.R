#Dynamic Lighting with a Sine Wave
#Author: Fabio Veronesi
#Reference: 

library(raster)

##Set the Working directory here:
#remember that R takes directory links in the format "c:/folder/subfolder"
setwd("c:/Shading_Sine_Wave")


##Loading Files
#This script has been tested with ASCII grids but it should work with every raster format 
#supported by the package Raster
dtm <- raster("dtm.asc")

##Set the projection
#Projections references can be found here: http://spatialreference.org/
proj4string(dtm)=CRS("+init=epsg:2056")



##Calculate Slope and Aspect
#This is done using the function terrain from the package Raster
#Both these derivatives are computed in Radians
slope<-terrain(dtm,opt='slope',unit='radians',neighbors=8)
aspect<-terrain(dtm,opt='aspect',unit='radians',neighbors=8)



##Calculte Azimuth
#First Aspect is converted in Degrees
#Then a new empty raster is created from it, named Azimuth

aspect.degrees<-terrain(dtm,opt='aspect',unit='degrees',neighbors=8)
azimuth<-raster(aspect.degrees)
names(azimuth)<-"azimuth"

#Azimuth is calculated using the Sine Wave equation
#The light sources can be changed by changing the values of MIN and MAX
MAX=315
MIN=280

A=(MAX-MIN)/2
B=180
C=B*(pi/180)
D=MAX-A

sine.wave<-function(x){A*sin(((2*pi)/B)*x+C)+D}

#Now the function sine.wave can be solved for each cell of the raster, using the aspect values in degrees
#the following line of code fill the atimuth raster created above with the values calculated by the sine.wave function
azimuth[]<-sine.wave(aspect.degrees[])*(pi/180)



##Calculate Zenith
#There are three possibilities for Zenith
#Standard: which assing a constant value of Zenith for the whole area
#Altitude: which corrects Zenith according to altitude
#Slope: which corrects Zenith according to Slope
#For more info please take a look at: ARTICLE



#Zenith Standard
#Here the user can change the Zenith angle by changing the value of Zen.Value
Zen.Value = 45
zenith<-raster(dtm)
names(zenith)<-"zenith"
zenith[]<-(Zen.Value)*(pi/180)



#Zenith Slope
#Here the user can change the minimum value of Zenith by changing Min.Zen
Min.Zen = 30
slope.deg<-terrain(dtm,opt='slope',unit='degrees',neighbors=8)
zenith<-raster(slope.deg)
names(zenith)<-"zenith"
slo<-(slope.deg[]-min(slope.deg[],na.rm=T))/(max(slope.deg[],na.rm=T)-min(slope.deg[],na.rm=T))
zenith[]<-((90-Min.Zen)*slo)*(pi/180)



#Zenith Altitude
#Here the user can change the minimum value of Zenith by changing Min.Zen
Min.Zen = 30
zenith<-raster(dtm)
names(zenith)<-"zenith"
alt<-(dtm[]-min(dtm[],na.rm=T))/(max(dtm[],na.rm=T)-min(dtm[],na.rm=T))
zenith[]<-((90-Min.Zen)*alt)*(pi/180)






##Hillshading
staked<-stack(slope,aspect,azimuth,zenith)
hill.shd<-raster(aspect)
Shading<-((cos(getValues(staked$zenith))*cos(getValues(staked$slope)))+(sin(getValues(staked$zenith))*sin(getValues(staked$slope))*cos(getValues(staked$azimuth)-getValues(staked$aspect))))
Shading[Shading<0]<-0
hill.shd[]<-255*Shading


##Save Hillshaded relief
#Here the file is saved into an ASCII grid
writeRaster(hill.shd,filename="Shaded_Relief.asc",format="ascii",overwrite=F)

