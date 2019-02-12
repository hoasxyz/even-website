.libPaths("E:/R-3.5.2/library")
install.packages("colorspace")
library(colorspace)

options(blogdown.generator.server = TRUE)
blogdown::serve_site()

require(readxl)
require(cowplot)
require(reprex)
require(plyr)
require(reshape2)
require(widgetframe)
library("highcharter")
library(gsubfn)

# 1 -----------------------------------------------------------------------
