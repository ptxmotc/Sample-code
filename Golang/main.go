package main

import "fmt"
import "./lib"

func main(){
	APPID := "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
	APPKEY := "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
	
	ptx := lib.PTXService{
		APPID,
		APPKEY,
	}

	//usage
	fmt.Println(ptx.Get("https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=10&$format=JSON"))
}
