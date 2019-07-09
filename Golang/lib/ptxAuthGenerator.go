package lib

import (
	"time"
	"net/http"
	"crypto/sha1"
	"crypto/hmac"
	"encoding/base64"
)


func AuthGenerator(APPID, APPKEY string) (string, string){
	xdate, sign := signGenerator(APPID, APPKEY);
	auth := "hmac username=\"" + APPID + "\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"" + sign + "\""
	
	return xdate, auth
}

func signGenerator(APPID, APPKEY string) (string, string){
	xdate := getServerTime()
	encryptXdate := "x-date: " + xdate
	encryptSign := hmac_sha1_generator(encryptXdate, APPKEY)

	return xdate, encryptSign
}

func getServerTime() string {
	//ptx platform time is GMT 0.
	return time.Now().UTC().Format(http.TimeFormat)
}

func hmac_sha1_generator(enc_xdate string, appkey string) string{
	key := []byte(appkey)
	mac := hmac.New(sha1.New, key)
	mac.Write([]byte(enc_xdate))
	mac_encrypted := base64.StdEncoding.EncodeToString(mac.Sum(nil))
	return mac_encrypted
}
