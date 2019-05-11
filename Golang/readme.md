# PTX Platform API Wrapper for Golang

## 使用範例
給予立即需要使用 ptx platform api 的開發者:
``` go
//從 local 或 GitHub 上獲取這個 Golang Wrapper
//若您從 GitHub 上獲取這個專案，請記得使用 go get https://....../lib
//import "########/lib" 

APPID := "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
APPKEY := "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";

//您只需要建立 PTXService 物件並置入 APPKEY
ptx := lib.PTXService{
    APPID,
    APPKEY,
}

//調用 ptx.Get(url) 即可獲得資料
fmt.Println(ptx.Get("https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=10&$format=JSON"))
```

## 測試
拉下專案到桌面，輸入指令執行。

``` shell
go run main.go
```

## 手動使用
若您對內建工具不滿，您也可以只利用 HMAC-SHA1 產生器，省去您重複寫 Auth Token 的時間。

#### 匯入 lib
``` go
import "從您的 GitHub 匯入.../lib"
```

### Common import for local
``` go
import "./lib"
```

#### 使用 AuthGenerator 工具
``` go
//直接獲取加密時的 xdate 時間資料及 http head auth token
xdate, auth := lib.AuthGenerator(APPID, APPKEY);

//自訂 http request 時只要將 xdate, auth 放入下列類似情境:
// request.setHeader("x-date", xdate)
// request.setHeader("Authorization", auth)
```

