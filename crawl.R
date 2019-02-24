rm(list=ls())
library("xml2")
library("rvest")
library("downloader")

# 1 -----------------------------------------------------------------------


t1 <- proc.time()
hs <- tibble()

for(i in 1:100){
  url <- paste("https://sz.lianjia.com/ershoufang/pg/d", i, sep = "")
  
  hs_info <- url %>%
    read_html() %>%
    html_nodes("div.houseInfo") %>%
    html_text() %>%
    str_split("\\|", simplify = TRUE)
  
  hs_info[,3] <- hs_info[,3] %>%
    str_remove("(平米)")
  
  hs_posi <- url %>%
    read_html() %>%
    html_nodes("div.positionInfo") %>%
    html_text() %>%
    str_split(" - ", simplify = TRUE)
  
  hs_pric <- url %>%
    read_html() %>%
    html_nodes("div.priceInfo") %>%
    html_text() %>%
    str_extract_all("(\\d{3,6})", simplify = TRUE)
  
  house <- cbind(hs_info,hs_posi,hs_pric) %>%
    as_tibble() %>%
    rename(小区名 = V1, 厅室 = V2, 面积 = V3, 朝向 = V4, 装饰 = V5,
              电梯 = V6, 楼层 = V7, 周边 = V8, 总价 = V9, 单价 = V10)
  
  hs <- rbind(hs, house)
  
}

hs$面积 <- as.numeric(hs$面积)
hs$总价 <- as.numeric(hs$总价)
hs$单价 <- as.numeric(hs$单价)

write.csv(hs,"深圳二手房.csv")

proc.time()-t1

hs <- read.csv("深圳二手房.csv", fileEncoding = "UTF-8") %>%
  select(-1)


# 2 -----------------------------------------------------------------------

for(i in 1901:2100){
  url <- paste("https://data.weather.gov.hk/gts/time/calendar/text/T", i,"e.txt", sep = "")
  name <- paste("T", i, "e.txt", sep = "")
  download(url = url, destfile = name)
}


wd <- tibble()

for(i in 2019:2020){
  url <- paste("https://hoas.xyz/txt/T", i,"e.txt", sep = "")
  
  wd_en <- fread(url, fill = TRUE, header = FALSE, skip = 2, select = 1:5, nrows = 365) %>%
    as_tibble()
  
  wd <- rbind(wd,wd_en)
}


