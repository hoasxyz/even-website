install.packages("widgetframe")

options(blogdown.generator.server = TRUE)
blogdown::serve_site()

require(readxl)
require(cowplot)
require(reprex)
require(plyr)
require(reshape2)
require(widgetframe)
library("highcharter")

line15 <- c(113,91,117,195)
line16 <- c(107,108,118,187)
line17 <- c(106,104,113,166)
line18 <- c(107,110,116,186)

grade15 <- read_xls("grade15.xls",sheet = 1,range = "A2:I1124",col_names = TRUE) %>%
  select(-(年级:班级),-班名) %>%
  dplyr::filter(总分 >= sum(line15)&
                    !((语文>=line15[1])&(数学>=line15[2])&(英语>=line15[3])&(理综>=line15[4])))
  
grade16 <- read_xls("grade16.xls",sheet = 1,range = "C3:H1126",col_names = TRUE) %>%
  dplyr::filter(总分 >= sum(line16)&
                    !((语文>=line16[1])&(数学>=line16[2])&(英语>=line16[3])&(理综>=line16[4])))

grade17 <- read_xls("grade17.xls",sheet = 1,range = "B1:G1065",col_names = TRUE) %>%
  dplyr::filter(理综 <= 300) %>%
  dplyr::filter(总分 >= sum(line17)&
                    !((语文>=line17[1])&(数学>=line17[2])&(英语>=line17[3])&(理综>=line17[4])))

grade18 <- read_xls("grade18.xls",sheet = 1,range = "C1:J989",col_names = TRUE) %>%
  select(-备注) %>%
  dplyr::filter(总分 >= sum(line18)&
                    !((语文>=line18[1])&(数学>=line18[2])&(英语>=line18[3])&(理综>=line18[4])))

chinese15 <- grade15 %>%
  dplyr::filter(语文<line15[1]) %>%
  select(语文)
chinese15$语文 <- as.numeric(chinese15$语文)
chinese16 <- grade16 %>%
  dplyr::filter(语文<line16[1]) %>%
  select(语文)
chinese17 <- grade17 %>%
  dplyr::filter(语文<line17[1]) %>%
  select(语文)
chinese18 <- grade18 %>%
  dplyr::filter(语文<line18[1]) %>%
  select(语文)
c <- rbind(chinese15,chinese16,chinese17,chinese18)
sdc <- rbind(-chinese15+line15[1],-chinese16+line16[1],-chinese17+line17[1],-chinese18+line18[1])

math15 <- grade15 %>%
  dplyr::filter(数学<line15[2]) %>%
  select(数学)
math16 <- grade16 %>%
  dplyr::filter(数学<line16[2]) %>%
  select(数学)
math17 <- grade17 %>%
  dplyr::filter(数学<line17[2]) %>%
  select(数学)
math18 <- grade18 %>%
  dplyr::filter(数学<line18[2]) %>%
  select(数学)
m <- rbind(math15,math16,math17,math18)
sdm <- rbind(-math15+line15[2],-math16+line16[2],-math17+line17[2],-math18+line18[2])

english15 <- grade15 %>%
  dplyr::filter(英语<line15[3]) %>%
  select(英语)
english16 <- grade16 %>%
  dplyr::filter(英语<line16[3]) %>%
  select(英语)
english17 <- grade17 %>%
  dplyr::filter(英语<line17[3]) %>%
  select(英语)
english18 <- grade18 %>%
  dplyr::filter(英语<line18[3]) %>%
  select(英语)
e <- rbind(english15,english16,english17,english18)
sde <- rbind(-english15+line15[3],-english16+line16[3],-english17+line17[3],-english18+line18[3])

science15 <- grade15 %>%
  dplyr::filter(理综<line15[4]) %>%
  select(理综)
science16 <- grade16 %>%
  dplyr::filter(理综<line16[4]) %>%
  select(理综)
science17 <- grade17 %>%
  dplyr::filter(理综<line17[4]) %>%
  select(理综)
science18 <- grade18 %>%
  dplyr::filter(理综<line18[4]) %>%
  select(理综)
s <- rbind(science15,science16,science17,science18)
sds <- rbind(-science15+line15[4],-science16+line16[4],-science17+line17[4],-science18+line18[4])

# This rename function is in plyr package!
cc <- sdc  %>%
  count("语文") %>%
  rename(c("语文" = "分差", "freq" = "语文"))
ee <- sde %>%
  count("英语") %>%
  rename(c("英语" = "分差", "freq" = "英语"))
mm <- sdm %>%
  count("数学") %>%
  rename(c("数学" = "分差", "freq" = "数学"))
ss <- sds %>%
  count("理综") %>%
  rename(c("理综" = "分差", "freq" = "理综"))

intg <- cc %>%
full_join(ee,by = "分差") %>%
  full_join(mm,by = "分差") %>%
  full_join(ss,by = "分差") %>%
  arrange(分差)
intg[is.na(intg)] <- 0
intg <- intg %>%
  melt(id = "分差") %>%
  plyr::rename(c("variable" = "科目", "value" = "人数"))

hc <- hchart(intg,"column",hcaes(x = "分差", y = "人数", group = "科目")) %>%
  hc_plotOptions(column= list(dataLabels = list(enabled =TRUE))) %>% 
  hc_title(text = "各科一本线分差分析图") %>%
  hc_yAxis(title = list(text = "人数",align = "middle"),
           tickInterval = 4,tickAmount = 4)
hc
htmlwidgets::saveWidget(hc,file = "oneline4.html", selfcontained = TRUE)

# 2 -----------------------------------------------------------------------


length(c[[语文]])
sum(m)
sum(e)
sum(s)
percent <- 0.8*c(length(c$语文),length(m$数学),length(e$英语),length(s$理综))


hchart(ss, "column",hcaes(x="理综",y="freq"), color = "#B71C1C",name = "理综分差") %>% 
  hc_title(text = "理综") %>%
  hc_legend() %>%
  hc_plotOptions(column= list(dataLabels = list(enabled =TRUE))) %>%
  hc_xAxis(title = list(text = "分差"),align = "middle") %>%
  hc_yAxis(title = list(text = "人数",align = "middle"),
           tickInterval = 4,tickAmount = 4) %>%
  hc_add_series(data = cc,"column",hcaes(x = "语文",y = "freq"),name = "语文分差") %>%
  hc_add_series(data = ee,"column",hcaes(x = "英语",y = "freq"),name = "英语分差") %>%
  hc_add_series(data = mm,"column",hcaes(x = "数学",y = "freq"),name = "数学分差")

highchart() %>% 
  hc_chart(type ="stock") %>%
  hc_add_series(data = sdc$语文, name = "Chinese")

hchart(sds$理综, color = "#B71C1C") %>% 
  hc_title(text = "Chinese") %>%
  hc_plotOptions(column= list(dataLabels = list(enabled =TRUE)))

hchart(sdc$语文, color = "#B71C1C") %>% 
  hc_title(text = "Chinese") %>%
  hc_plotOptions(column= list(dataLabels = list(enabled =TRUE)))


  hc_xAxis(title = list(text = "语文分差")) %>%
  hc_yAxis(title = list(text = "Count"))

length(sde) <- length(sdm)
hcs+hcc

ggplot(data = sdm,aes(数学))+
  geom_bar()

ggplot(data = sde,aes(英语))+
  geom_bar()

ggplot(data = sds,aes(理综))+
  geom_bar()
