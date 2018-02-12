# coding=utf-8
# Python 2.7.13
import urllib2
import hmac
import base64
from wsgiref.handlers import format_date_time
from datetime import datetime
from time import mktime

BUS_API_STOPS = "http://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/Taipei/559?$top=1&$format=JSON&$select=RouteName,RouteUID,Direction,Stops"

APP_ID = 'my long app id'
APP_key = 'my long app key'

xdate = format_date_time(mktime(datetime.now().timetuple()))
# use APPKey to encrypt current daytime
from hashlib import sha1
hashed = hmac.new(APP_key, 'x-date: ' + xdate, sha1)
signature = base64.b64encode(hashed.digest()).decode()

# put signature,APPID into Authorization
Authorization = 'hmac username="' + APP_ID + '", ' +\
    'algorithm="hmac-sha1", '+\
    'headers="x-date", '+\
    'signature="' + signature + '"'
    
request = urllib2.Request(BUS_API_STOPS, headers={
    'Authorization': Authorization,
    'x-date': format_date_time(mktime(datetime.now().timetuple())),
    'Accept - Encoding': 'gzip'
    })
try:
    # response is here
    response = urllib2.urlopen(request)
except urllib2.HTTPError as e:
    # may be 401, 403, 404... etc
    error_message = e.read()
    print error_message
