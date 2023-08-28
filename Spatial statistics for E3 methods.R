#Load libraries
library(spatstat)
library(tidyverse)
library(openxlsx)

#Read in Coordinates of cells (based on DAPI+ nuclei) from ImageJ "Analyze particles" Results
#The "Centroid" Parameter in Analyze > Set Measurements should be checked to obtain the coordinate columns "X" and "Y"
df <- read_csv("PPP example file.csv")

#the example file is a square picture of 1024*1024 pixels. the values in the "window =" may differ according to the size of image and scaling
pts <- ppp(df$X,df$Y, window = square(1024)) 

#plot pts to check whether it matches the image (May be excluded once the validity of the code has been confirmed)
plot(pts)

#Nearest Neighbor distances           
NND <- nndist(pts, k = 1)

#Spatial G-function
Gfunction <- envelope(pts, Gest)
plot(Gfunction)

#Export Results to Excel for further analysis
write.xlsx(NND, "NND.xlsx")
write.xlsx(Gfunction, "Spatial G function.xlsx")