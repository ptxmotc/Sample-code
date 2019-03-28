package lib

import "net/http"
import "io/ioutil"

type PTXService struct{
	AppID string
	AppKey string
}

func (p *PTXService) Get(url string) string{

	//AuthGenerator function is form ./ptxAuthGrenerator.go
	xdate, auth := AuthGenerator(p.AppID, p.AppKey);

	client := &http.Client{}
	req, _ := http.NewRequest("GET", url, nil)
	req.Header.Set("x-date", xdate)
	req.Header.Set("Authorization", auth)
	res, _ := client.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	return string(body)
}