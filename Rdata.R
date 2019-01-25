.libPaths("E:/R-3.5.2/library")
install.packages("tibble")
library(tibble)

detach("package:tibble")
detach("package:tidyverse")


install.packages("installr")

library(installr)
updateR()

packageVersion("tibble")

devtools::install_github('tidyverse/tibble')

library("devtools")
install_version("tibble",version="2.0.0")


# 2xi'an -----------------------------------------------------------------------

require(leaflet)
require(readxl)
options(digits = 10)
xian <- read_xlsx("E:/!Learning_R_is_awesome!/my website/xian.xlsx")
xian$property <- as.factor(xian$property)

getcolor <- function(xian) {
  sapply(xian$property, function(ppt){
    if (ppt == 'Tourist') {
      "green"
    } else if(ppt == 'Station') {
      "red"
    } else{
      "blue"
    }
  })
}
geticon <- function(xian){
  sapply(xian$property, function(ppt){
    if (ppt == 'Tourist') {
      "eye"
    } else if(ppt == 'Station') {
      "playstation"
    } else{
      "beer"
    }
  })
}
icons <- awesomeIcons(
  icon = geticon(xian),
  iconColor = 'white',
  library = 'ion',
  markerColor = getcolor(xian)
)

leaflet(data = xian) %>% 
  addTiles() %>%
  addAwesomeMarkers(~Lon,~Lat,label = ~Place,
                    popup = ifelse(is.na(xian$Price),as.character(xian$property),
                                   paste("Price(Adult):",xian$Price,"yuan",'<br>',
                                         "Period:",xian$Hours,"hours")),
                    icon = icons)
