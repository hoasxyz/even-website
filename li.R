.libPaths("E:/R-3.5.2/library")
remotes::install_github("ThinkR-open/remedy")
install.packages("rmd")
library(rmd)
install.packages('recharts',
                 repos = c('http://yihui.name/xran', 'http://cran.rstudio.com'))
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
library(rvest)

# 1 -----------------------------------------------------------------------

url<-'https://hoas.xyz/post/%E7%94%A8github%E5%81%9A%E5%9B%BE%E5%BA%8A%E7%9A%84%E5%B0%9D%E8%AF%95/'
web<-read_html(url,encoding="utf-8") #读取数据，规定编码
position<-web %>% html_nodes("div.highlight") %>% html_text()
