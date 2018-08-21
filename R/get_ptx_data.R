library(httr)

get_ptx_data <- function(app_id, app_key, url, Windows = FALSE){
  # First save your current locale
  loc <- Sys.getlocale("LC_TIME")
  
  if (Windows){
    Sys.setlocale(category = "LC_TIME", locale = "English_United States.1252")
  } else {
    Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")
  }
  
  # "Tue, 21 Aug 2018 01:18:42 GMT"
  xdate <- format(as.POSIXlt(Sys.time(), tz = "GMT"), "%a, %d %b %Y %H:%M:%S GMT")
  sig <- hmac_sha1(app_key, paste("x-date:", xdate)) 
  
  # hmac username="APP ID", algorithm="hmac-sha1", headers="x-date", 
  # signature="Base64(HMAC-SHA1("x-date: " + x-date , APP Key))"
  
  authorization <- paste0(
    'hmac username="', app_id, '", ',
    'algorithm="hmac-sha1", ',
    'headers="x-date", ',
    'signature="', sig, '\"', sep = '')
  
  auth_header <- c(
    'Authorization'= authorization,
    'x-date'= as.character(xdate))
  
  dat <- GET(url, 
             config = config(ssl_verifypeer = 0L), 
             add_headers(.headers = auth_header))
  
  print(http_status(dat)$message)
  
  # Set back to origin locale
  Sys.setlocale('LC_TIME', loc)
  
  # return(dat)
  return(content(dat))
}
