---
title: Xinanjiang Rainfall-Runoff Model
author: Hoas
date: '2019-02-11'
slug: xinanjiang-rainfall-runoff-model
categories:
  - course
tags:
  - R
lastmod: '2019-02-11T21:54:56+08:00'
keywords: [Xinanjiang Rainfall-Runoff Model,R,新安江模型,三水源新安江模型,R语言]
description: 'Xinanjiang Rainfall-Runoff Model with R. R语言解决新安江三水源模型'
comment: yes
toc: yes
autoCollapseToc: no
postMetaInFooter: yes
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: yes
mathjaxEnableSingleDollar: yes
mathjaxEnableAutoNumber: yes
hideHeaderAndFooter: no
---
  三水源新安江模型R语言解决代码。
![Xinanjiang Rainfall-Runoff Model](http://www.yunqishui.com/assets/1/users/s15168/6347f565cf974be7859b0e7ae6dbd029.png)
<!--more-->




```r
# Xinanjiang rainfall-runoff model -----------------------------------------------------------------------

# Set the parameters
WM <- 126; WUM <- 63; WLM <- 13; WDM <- 50; K <- 48; F <- 6448;
KC <- 0.71; C <- 0.17; B <- 3; IMP <- 0.001; FE <- 0.8; WMM <- (1+B)*WM
SM <- 36; EX <- 0.46; KG <- 0.05; KKG <- 0.995; KSS <- 0.06; KKSS <- 0.83
W0 <- WM*FE; WU0 <- WUM*FE; WL0 <- WLM*FE; WD0 <- WDM*FE; S0 <- SM*FE
MS <- SM*(1+EX); U <- F/(3.6*24)
UH <- c(0,460.5,140.5,67.8,35.2,18.9,10.3,5.7,3.2,1.8,1.0,0.6,0.3,0.2,0.1,0.1,0)

# Input the raw data
raw <- read_xlsx("E:/1R/website/Excel/xunhe.xlsx",sheet = 1)
raw$date <- as.Date(raw$date)

# 1 -----------------------------------------------------------------------

# Make the origional tabulation of Three-layer evaporation model
thrlay <- raw %>%
  mutate(EP = E0*KC, EU = NA, EL = NA, ED = NA, E = NA, PE = NA,
         WU = NA, WL = NA, WD = NA, W = NA, R = NA, a = NA) %>%
  within({
    WU[1] <- WU0
    WL[1] <- WL0
    WD[1] <- WD0
    W[1] <-WU[1]+WL[1]+WD[1]
    a[1] <- WMM*(1-(1-W[1]/WM)^(1/(1+B)))
  })

# Three-layer evaporation model and Saturation excess runoff model
thrlay <- within(thrlay,{
  for(i in seq_along(P)) {
    if (i > 1461) {
      break
    } else {
      if (WU[i]+P[i]<EP[i]) EU[i] <- WU[i]+P[i]
      if (WU[i]+P[i]>=EP[i]){ 
        EU[i]<-EP[i]
        EL[i]<-0
        ED[i]<-0
      } else if (WL[i]>=C*WLM) {
        EU[i]<-WU[i]+P[i]
        EL[i]<-(EP[i]-EU[i])*WL[i]/WLM
        ED[i]<-0
      } else if (WL[i]>=C*(EP[i]-EU[i])) {                     
        EU[i]<-WU[i]+P[i]
        EL[i]<-C*(EP[i]-EU[i])
        ED[i]<-0
      } else {
        EU[i]<-WU[i]+P[i]
        EL[i]<-WL[i]
        ED[i]<-C*(EP[i]-EU[i])-EL[i]
      }
      E[i] <- EU[i]+EL[i]+ED[i]
      PE[i] <- P[i]-E[i]
      
      if (PE[i] <= 0) {
        R[i] <- 0
      } else if ((a[i]+PE[i]) < WMM) {
        R[i] <- PE[i]+W[i]-WM+WM*(1-(PE[i]+a[i])/WMM)^(B+1)
      } else {
        R[i] <- PE[i]-WM+W[i]
      }
      if (R[i] < 0) R[i] <- 0
      
      if ((P[i]+WU[i]-EU[i]-R[i]) <= WUM) { # WU
        WU[i+1] <- ifelse(P[i]+WU[i]-EU[i]-R[i] <= 0,0,P[i]+WU[i]-EU[i]-R[i])
        WL[i+1] <- ifelse(WL[i]-EL[i] <= 0,0,WL[i]-EL[i])
        WD[i+1] <- ifelse(WD[i]-ED[i] <=0,0,WD[i]-ED[i])
      } else if((P[i]+WU[i]-EU[i]-R[i]-WUM+WL[i]-EL[i])<=WLM) {
        WU[i+1] <- WUM
        WL[i+1] <- P[i]+WU[i]-EU[i]-R[i]-WUM+WL[i]-EL[i]
        WD[i+1] <- ifelse(WD[i]-ED[i] <=0,0,WD[i]-ED[i])
      } else if((P[i]+WU[i]-EU[i]-R[i]-WUM+WL[i]-EL[i]-WLM+WD[i]-ED[i])<=WDM) {
        WU[i+1] <- WUM
        WL[i+1] <- WLM
        WD[i+1] <- P[i]+WU[i]-EU[i]-R[i]-WUM+WL[i]-EL[i]-WLM+WD[i]-ED[i]
      } else {
        WU[i+1] <- WUM
        WL[i+1] <- WLM
        WD[i+1] <- WDM
        residue <- P[i]+WU[i]-EU[i]-R[i]-WUM+WL[i]-EL[i]-WLM+WD[i]-ED[i]-WDM
      }
      W[i+1] <- WU[i+1]+WL[i+1]+WD[i+1]
      a[i+1] <- WMM*(1-(1-W[i+1]/WM)^(1/(1+B)))
    }
  }
})

# 2 -----------------------------------------------------------------------

# Make the origional tabulation of Three-conponent model
thrwat <- thrlay %>%
  mutate(FR = R/PE, FRt = 1-(1-W/WM)^(B/(1+B)),
         S = NA, AU = NA, RS = NA, RSS = NA, RG = NA,
         QRS = NA, QRSS = NA, QRG = NA, QR = NA, RC = NA) %>%
  within({
    S[1] <- SM*FE
    AU[1] <- MS*(1-(1-S[1]/SM)^(1/(1+EX)))
  })

# Calculate Three-conponent model
thrwat <- thrwat %>%
  within({
    for(i in seq_along(P)) {
      if (PE[i] <= 0) {
        RS[i] <- 0
        RSS[i] <- S[i]*KSS*FRt[i]
        RG[i] <- S[i]*KG*FRt[i]
        S[i+1] <- (1-KSS-KG)*S[i]
        AU[i+1] <- MS*(1-(1-S[i+1]/SM)^(1/(1+EX)))
      } else if (PE[i]+AU[i] < MS) {
        RS[i] <- ifelse((PE[i]-SM+S[i]+SM*(1-(PE[i]+AU[i])/MS)^(1+EX))*FR[i] <=0,
                        0,(PE[i]-SM+S[i]+SM*(1-(PE[i]+AU[i])/MS)^(1+EX))*FR[i])
        RSS[i] <- (SM-SM*(1-(PE[i]+AU[i])/MS)^(1+EX))*KSS*FR[i]
        RG[i] <- (SM-SM*(1-(PE[i]+AU[i])/MS)^(1+EX))*KG*FR[i]
        S[i+1] <- (1-KSS-KG)*(SM-SM*(1-(PE[i]+AU[i])/MS)^(1+EX))
        AU[i+1] <- MS*(1-(1-S[i+1]/SM)^(1/(1+EX)))
      } else {
        RS[i] <- ifelse((PE[i]-SM+S[i])*FR[i] <= 0,
                        0,(PE[i]-SM+S[i])*FR[i])
        RSS[i] <- SM*KSS*FR[i]
        RG[i] <- SM*KG*FR[i]
        S[i+1] <- (1-KSS-KG)*SM
        AU[i+1] <- MS*(1-(1-S[i+1]/SM)^(1/(1+EX)))
      }
      
    }
    QRSS[1] <- (1-KKSS)*RSS[1]*U
    QRG[1] <- (1-KKG)*RG[1]*U
    for (i in 1:1460) {
      QRSS[i+1] <- KKSS*QRSS[i]+(1-KKSS)*RSS[i+1]*U
      QRG[i+1] <- KKG*QRG[i]+(1-KKG)*RG[i+1]*U
    }
    
    # QRS <- convolve((RS*(1-IMP)+IMP*P)/10,UH,type = "open")[1:length(P)]
    QRS <- polyprod((RS*(1-IMP)+IMP*P)/10,UH)[1:length(P)] # Convolution
    QR <- QRS+QRSS+QRG # Total runoff
    RC <- QR*3600*24/F/1000 # Total runoff depth
  }) %>%
  select(-i)

# 3 -----------------------------------------------------------------------

# Select the elements that will be used
xhh <- thrwat %>%
  select("日期" = date, "降水" = P, "实测流量" = Q,
         "模拟流量" = QR, "模拟径流" = RC , "实测径流" = R)

# Filter each flood number
hh <- list(
  "870513" = xhh %>%
    dplyr::filter(日期 >= ymd(870510),日期 <= ymd(870520)),
  "870614" = xhh %>%
    dplyr::filter(日期 >= ymd(870611),日期 <= ymd(870620)),
  "870804" = xhh %>%
    dplyr::filter(日期 >= ymd(870802),日期 <= ymd(870812)),
  "870903" = xhh %>%
    dplyr::filter(日期 >= ymd(870901),日期 <= ymd(870909)),
  "880407" = xhh %>%
    dplyr::filter(日期 >= ymd(880401),日期 <= ymd(880420)),
  "880505" = xhh %>%
    dplyr::filter(日期 >= ymd(880505),日期 <= ymd(880519)),
  "880705" = xhh %>%
    dplyr::filter(日期 >= ymd(880702),日期 <= ymd(880716)),
  "880819" = xhh %>%
    dplyr::filter(日期 >= ymd(880817),日期 <= ymd(880824)),
  "890429" = xhh %>%
    dplyr::filter(日期 >= ymd(890426),日期 <= ymd(890509)),
  "890711" = xhh %>%
    dplyr::filter(日期 >= ymd(890705),日期 <= ymd(890722)),
  "890820" = xhh %>%
    dplyr::filter(日期 >= ymd(890814),日期 <= ymd(890825)),
  "890928" = xhh %>%
    dplyr::filter(日期 >= ymd(890923),日期 <= ymd(891004)),
  "900501" = xhh %>%
    dplyr::filter(日期 >= ymd(900428),日期 <= ymd(900513)),
  "900701" = xhh %>%
    dplyr::filter(日期 >= ymd(900629),日期 <= ymd(900711)),
  "900816" = xhh %>%
    dplyr::filter(日期 >= ymd(900812),日期 <= ymd(900828))
)

# Calculate the total elements of each flood
sumRC <- 0; sumP <- 0; sumQ <- 0; sumR <- 0
for (i in seq_along(hh)) {
  sumRC[i] <- sum(hh[[i]][5])
  sumP[i] <- sum(hh[[i]][2])
  sumQ[i] <- sum(hh[[i]][3])
  sumR[i] <- sum(hh[[i]][6])
}
ssum <- tibble(sumP,sumQ,sumRC,sumR)

# Calculate the DC value of the whole forecast period
thrwat %>%
  with({
    DC <<- 1-sum((Q-QR)^2)/sum((Q-mean(Q))^2)
  })

# Calculate the DC value of each flood
nDC <- 0
hh %>%
  with({
    for (i in seq_along(hh)) {
      nDC[i] <<- 1-sum((hh[[i]]$实测流量-hh[[i]]$模拟流量)^2)/
        sum((hh[[i]]$实测流量-mean(hh[[i]]$实测流量))^2)
    }
    
  })

maxQ <- 0; maxQR <- 0
for (i in seq_along(hh)) {
  maxQ[i] <- max(hh[[i]]$实测流量)
  maxQR[i] <- max(hh[[i]]$模拟流量)
}

thrlay
```

```
## # A tibble: 1,461 x 17
##    date           Q     P    E0    EP    EU    EL    ED     E      PE    WU
##    <date>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>
##  1 1987-01-01  16.5   0.4  0.6  0.426 0.426     0     0 0.426 -0.0260  50.4
##  2 1987-01-02  16.5   0    1.05 0.745 0.745     0     0 0.745 -0.745   50.4
##  3 1987-01-03  16.1   0.2  1    0.71  0.71      0     0 0.71  -0.51    49.6
##  4 1987-01-04  15.6   0    1.25 0.888 0.888     0     0 0.888 -0.888   49.1
##  5 1987-01-05  15.6   0    1.6  1.14  1.14      0     0 1.14  -1.14    48.2
##  6 1987-01-06  15.6   0    2.75 1.95  1.95      0     0 1.95  -1.95    47.1
##  7 1987-01-07  15.6   0    2.6  1.85  1.85      0     0 1.85  -1.85    45.1
##  8 1987-01-08  14.9   0    2    1.42  1.42      0     0 1.42  -1.42    43.3
##  9 1987-01-09  14.8   0    2.5  1.78  1.78      0     0 1.78  -1.78    41.9
## 10 1987-01-10  14.8   0    2.05 1.46  1.46      0     0 1.46  -1.46    40.1
## # ... with 1,451 more rows, and 6 more variables: WL <dbl>, WD <dbl>,
## #   W <dbl>, R <dbl>, a <dbl>, i <int>
```

```r
knitr::kable(head(thrlay),"html",align = "c")
```

<table>
 <thead>
  <tr>
   <th style="text-align:center;"> date </th>
   <th style="text-align:center;"> Q </th>
   <th style="text-align:center;"> P </th>
   <th style="text-align:center;"> E0 </th>
   <th style="text-align:center;"> EP </th>
   <th style="text-align:center;"> EU </th>
   <th style="text-align:center;"> EL </th>
   <th style="text-align:center;"> ED </th>
   <th style="text-align:center;"> E </th>
   <th style="text-align:center;"> PE </th>
   <th style="text-align:center;"> WU </th>
   <th style="text-align:center;"> WL </th>
   <th style="text-align:center;"> WD </th>
   <th style="text-align:center;"> W </th>
   <th style="text-align:center;"> R </th>
   <th style="text-align:center;"> a </th>
   <th style="text-align:center;"> i </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1987-01-01 </td>
   <td style="text-align:center;"> 16.5 </td>
   <td style="text-align:center;"> 0.4 </td>
   <td style="text-align:center;"> 0.60 </td>
   <td style="text-align:center;"> 0.4260 </td>
   <td style="text-align:center;"> 0.4260 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0.4260 </td>
   <td style="text-align:center;"> -0.0260 </td>
   <td style="text-align:center;"> 50.4000 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 100.8000 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 166.9549 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-02 </td>
   <td style="text-align:center;"> 16.5 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 1.05 </td>
   <td style="text-align:center;"> 0.7455 </td>
   <td style="text-align:center;"> 0.7455 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0.7455 </td>
   <td style="text-align:center;"> -0.7455 </td>
   <td style="text-align:center;"> 50.3740 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 100.7740 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 166.8680 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-03 </td>
   <td style="text-align:center;"> 16.1 </td>
   <td style="text-align:center;"> 0.2 </td>
   <td style="text-align:center;"> 1.00 </td>
   <td style="text-align:center;"> 0.7100 </td>
   <td style="text-align:center;"> 0.7100 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0.7100 </td>
   <td style="text-align:center;"> -0.5100 </td>
   <td style="text-align:center;"> 49.6285 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 100.0285 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 164.4043 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-04 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 1.25 </td>
   <td style="text-align:center;"> 0.8875 </td>
   <td style="text-align:center;"> 0.8875 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0.8875 </td>
   <td style="text-align:center;"> -0.8875 </td>
   <td style="text-align:center;"> 49.1185 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 99.5185 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 162.7493 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-05 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 1.60 </td>
   <td style="text-align:center;"> 1.1360 </td>
   <td style="text-align:center;"> 1.1360 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1.1360 </td>
   <td style="text-align:center;"> -1.1360 </td>
   <td style="text-align:center;"> 48.2310 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 98.6310 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 159.9254 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-06 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 2.75 </td>
   <td style="text-align:center;"> 1.9525 </td>
   <td style="text-align:center;"> 1.9525 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1.9525 </td>
   <td style="text-align:center;"> -1.9525 </td>
   <td style="text-align:center;"> 47.0950 </td>
   <td style="text-align:center;"> 10.4 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 97.4950 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 156.4093 </td>
   <td style="text-align:center;"> 1461 </td>
  </tr>
</tbody>
</table>

```r
thrwat
```

```
## # A tibble: 1,461 x 28
##    date           Q     P    E0    EP    EU    EL    ED     E      PE    WU
##    <date>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>
##  1 1987-01-01  16.5   0.4  0.6  0.426 0.426     0     0 0.426 -0.0260  50.4
##  2 1987-01-02  16.5   0    1.05 0.745 0.745     0     0 0.745 -0.745   50.4
##  3 1987-01-03  16.1   0.2  1    0.71  0.71      0     0 0.71  -0.51    49.6
##  4 1987-01-04  15.6   0    1.25 0.888 0.888     0     0 0.888 -0.888   49.1
##  5 1987-01-05  15.6   0    1.6  1.14  1.14      0     0 1.14  -1.14    48.2
##  6 1987-01-06  15.6   0    2.75 1.95  1.95      0     0 1.95  -1.95    47.1
##  7 1987-01-07  15.6   0    2.6  1.85  1.85      0     0 1.85  -1.85    45.1
##  8 1987-01-08  14.9   0    2    1.42  1.42      0     0 1.42  -1.42    43.3
##  9 1987-01-09  14.8   0    2.5  1.78  1.78      0     0 1.78  -1.78    41.9
## 10 1987-01-10  14.8   0    2.05 1.46  1.46      0     0 1.46  -1.46    40.1
## # ... with 1,451 more rows, and 17 more variables: WL <dbl>, WD <dbl>,
## #   W <dbl>, R <dbl>, a <dbl>, FR <dbl>, FRt <dbl>, S <dbl>, AU <dbl>,
## #   RS <dbl>, RSS <dbl>, RG <dbl>, QRS <dbl>, QRSS <dbl>, QRG <dbl>,
## #   QR <dbl>, RC <dbl>
```

```r
knitr::kable(head(thrwat),"html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> Q </th>
   <th style="text-align:right;"> P </th>
   <th style="text-align:right;"> E0 </th>
   <th style="text-align:right;"> EP </th>
   <th style="text-align:right;"> EU </th>
   <th style="text-align:right;"> EL </th>
   <th style="text-align:right;"> ED </th>
   <th style="text-align:right;"> E </th>
   <th style="text-align:right;"> PE </th>
   <th style="text-align:right;"> WU </th>
   <th style="text-align:right;"> WL </th>
   <th style="text-align:right;"> WD </th>
   <th style="text-align:right;"> W </th>
   <th style="text-align:right;"> R </th>
   <th style="text-align:right;"> a </th>
   <th style="text-align:right;"> FR </th>
   <th style="text-align:right;"> FRt </th>
   <th style="text-align:right;"> S </th>
   <th style="text-align:right;"> AU </th>
   <th style="text-align:right;"> RS </th>
   <th style="text-align:right;"> RSS </th>
   <th style="text-align:right;"> RG </th>
   <th style="text-align:right;"> QRS </th>
   <th style="text-align:right;"> QRSS </th>
   <th style="text-align:right;"> QRG </th>
   <th style="text-align:right;"> QR </th>
   <th style="text-align:right;"> RC </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1987-01-01 </td>
   <td style="text-align:right;"> 16.5 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.4260 </td>
   <td style="text-align:right;"> 0.4260 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.4260 </td>
   <td style="text-align:right;"> -0.0260 </td>
   <td style="text-align:right;"> 50.4000 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 100.8000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 166.9549 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.7009302 </td>
   <td style="text-align:right;"> 28.80000 </td>
   <td style="text-align:right;"> 35.10545 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.2112075 </td>
   <td style="text-align:right;"> 1.0093396 </td>
   <td style="text-align:right;"> 0.000000 </td>
   <td style="text-align:right;"> 15.36663 </td>
   <td style="text-align:right;"> 0.3766332 </td>
   <td style="text-align:right;"> 15.74327 </td>
   <td style="text-align:right;"> 0.2109520 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1987-01-02 </td>
   <td style="text-align:right;"> 16.5 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.05 </td>
   <td style="text-align:right;"> 0.7455 </td>
   <td style="text-align:right;"> 0.7455 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.7455 </td>
   <td style="text-align:right;"> -0.7455 </td>
   <td style="text-align:right;"> 50.3740 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 100.7740 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 166.8680 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.7006989 </td>
   <td style="text-align:right;"> 25.63200 </td>
   <td style="text-align:right;"> 30.15339 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.0776188 </td>
   <td style="text-align:right;"> 0.8980156 </td>
   <td style="text-align:right;"> 0.018420 </td>
   <td style="text-align:right;"> 26.42610 </td>
   <td style="text-align:right;"> 0.7098429 </td>
   <td style="text-align:right;"> 27.15436 </td>
   <td style="text-align:right;"> 0.3638549 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1987-01-03 </td>
   <td style="text-align:right;"> 16.1 </td>
   <td style="text-align:right;"> 0.2 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 0.7100 </td>
   <td style="text-align:right;"> 0.7100 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.7100 </td>
   <td style="text-align:right;"> -0.5100 </td>
   <td style="text-align:right;"> 49.6285 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 100.0285 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 164.4043 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.6940892 </td>
   <td style="text-align:right;"> 22.81248 </td>
   <td style="text-align:right;"> 26.14019 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.9500337 </td>
   <td style="text-align:right;"> 0.7916948 </td>
   <td style="text-align:right;"> 0.005620 </td>
   <td style="text-align:right;"> 33.98677 </td>
   <td style="text-align:right;"> 1.0017131 </td>
   <td style="text-align:right;"> 34.99411 </td>
   <td style="text-align:right;"> 0.4689036 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1987-01-04 </td>
   <td style="text-align:right;"> 15.6 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.25 </td>
   <td style="text-align:right;"> 0.8875 </td>
   <td style="text-align:right;"> 0.8875 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.8875 </td>
   <td style="text-align:right;"> -0.8875 </td>
   <td style="text-align:right;"> 49.1185 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 99.5185 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 162.7493 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.6895948 </td>
   <td style="text-align:right;"> 20.30311 </td>
   <td style="text-align:right;"> 22.79230 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.8400550 </td>
   <td style="text-align:right;"> 0.7000458 </td>
   <td style="text-align:right;"> 0.011922 </td>
   <td style="text-align:right;"> 38.86683 </td>
   <td style="text-align:right;"> 1.2579254 </td>
   <td style="text-align:right;"> 40.13668 </td>
   <td style="text-align:right;"> 0.5378116 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1987-01-05 </td>
   <td style="text-align:right;"> 15.6 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.60 </td>
   <td style="text-align:right;"> 1.1360 </td>
   <td style="text-align:right;"> 1.1360 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.1360 </td>
   <td style="text-align:right;"> -1.1360 </td>
   <td style="text-align:right;"> 48.2310 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 98.6310 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 159.9254 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.6818248 </td>
   <td style="text-align:right;"> 18.06977 </td>
   <td style="text-align:right;"> 19.95267 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.7392249 </td>
   <td style="text-align:right;"> 0.6160207 </td>
   <td style="text-align:right;"> 0.004218 </td>
   <td style="text-align:right;"> 41.63804 </td>
   <td style="text-align:right;"> 1.4815027 </td>
   <td style="text-align:right;"> 43.12376 </td>
   <td style="text-align:right;"> 0.5778370 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1987-01-06 </td>
   <td style="text-align:right;"> 15.6 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 2.75 </td>
   <td style="text-align:right;"> 1.9525 </td>
   <td style="text-align:right;"> 1.9525 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.9525 </td>
   <td style="text-align:right;"> -1.9525 </td>
   <td style="text-align:right;"> 47.0950 </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 97.4950 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 156.4093 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.6719705 </td>
   <td style="text-align:right;"> 16.08209 </td>
   <td style="text-align:right;"> 17.51809 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.6484015 </td>
   <td style="text-align:right;"> 0.5403346 </td>
   <td style="text-align:right;"> 0.002112 </td>
   <td style="text-align:right;"> 42.78587 </td>
   <td style="text-align:right;"> 1.6757200 </td>
   <td style="text-align:right;"> 44.46370 </td>
   <td style="text-align:right;"> 0.5957915 </td>
  </tr>
</tbody>
</table>

```r
xhh
```

```
## # A tibble: 1,461 x 6
##    日期        降水 实测流量 模拟流量 模拟径流 实测径流
##    <date>     <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
##  1 1987-01-01   0.4     16.5     15.7    0.211        0
##  2 1987-01-02   0       16.5     27.2    0.364        0
##  3 1987-01-03   0.2     16.1     35.0    0.469        0
##  4 1987-01-04   0       15.6     40.1    0.538        0
##  5 1987-01-05   0       15.6     43.1    0.578        0
##  6 1987-01-06   0       15.6     44.5    0.596        0
##  7 1987-01-07   0       15.6     44.5    0.596        0
##  8 1987-01-08   0       14.9     43.6    0.584        0
##  9 1987-01-09   0       14.8     42.1    0.564        0
## 10 1987-01-10   0       14.8     40.1    0.537        0
## # ... with 1,451 more rows
```

```r
knitr::kable(head(xhh),"html",align = "c")
```

<table>
 <thead>
  <tr>
   <th style="text-align:center;"> 日期 </th>
   <th style="text-align:center;"> 降水 </th>
   <th style="text-align:center;"> 实测流量 </th>
   <th style="text-align:center;"> 模拟流量 </th>
   <th style="text-align:center;"> 模拟径流 </th>
   <th style="text-align:center;"> 实测径流 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1987-01-01 </td>
   <td style="text-align:center;"> 0.4 </td>
   <td style="text-align:center;"> 16.5 </td>
   <td style="text-align:center;"> 15.74327 </td>
   <td style="text-align:center;"> 0.2109520 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-02 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 16.5 </td>
   <td style="text-align:center;"> 27.15436 </td>
   <td style="text-align:center;"> 0.3638549 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-03 </td>
   <td style="text-align:center;"> 0.2 </td>
   <td style="text-align:center;"> 16.1 </td>
   <td style="text-align:center;"> 34.99411 </td>
   <td style="text-align:center;"> 0.4689036 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-04 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 40.13668 </td>
   <td style="text-align:center;"> 0.5378116 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-05 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 43.12376 </td>
   <td style="text-align:center;"> 0.5778370 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1987-01-06 </td>
   <td style="text-align:center;"> 0.0 </td>
   <td style="text-align:center;"> 15.6 </td>
   <td style="text-align:center;"> 44.46370 </td>
   <td style="text-align:center;"> 0.5957915 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
</tbody>
</table>

```r
kable(head(cbind(mtcars, mtcars)), "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.620 </td>
   <td style="text-align:right;"> 16.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.620 </td>
   <td style="text-align:right;"> 16.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.875 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.875 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 3.85 </td>
   <td style="text-align:right;"> 2.320 </td>
   <td style="text-align:right;"> 18.61 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 3.85 </td>
   <td style="text-align:right;"> 2.320 </td>
   <td style="text-align:right;"> 18.61 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.215 </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.215 </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Valiant </td>
   <td style="text-align:right;"> 18.1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.460 </td>
   <td style="text-align:right;"> 20.22 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 18.1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.460 </td>
   <td style="text-align:right;"> 20.22 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

```r
# Output the information of each flood
openxlsx::write.xlsx(hh,"洪号1.xlsx")
xhh %>%
  openxlsx::write.xlsx("整体.xlsx")
```
  Rmd在网站上生成的表格还不知道如何定制，比如上例就是rmd直接生成的文件中的[表格](https://haozhu233.github.io/kableExtra/awesome_table_in_html_cn.html)和网页上的不一样，这是因为使用了别的package，如果只用knitr::kable的话会更好。
