## PTX Public Transport API using R Code

- https://github.com/ptxmotc/Sample-code
- usage: `get_ptx_data(app_id, app_key, url)`


```
app_id <- 'your_app_id'
app_key <- 'your_app_key'
url <- 'https://ptx.transportdata.tw/MOTC/v2/Bus/Stop/City/YilanCounty?$top=30&$format=xml'

x <- get_ptx_data(app_id, app_key, url)

library(XML)
dat <- xmlParse(x, encoding = 'utf-8') # 以 xmlParse 解析 XML 檔案
xmlfiles <- xmlRoot(dat) # 將 root 設定到 content 層級（一個偷吃步的做法）
y <- xmlToDataFrame(xmlfiles, stringsAsFactors = FALSE) # 轉換成 dataframe
head(y)

```