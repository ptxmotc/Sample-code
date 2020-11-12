APP_ID = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'
APP_KEY = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'

require 'httparty' # https://github.com/jnunemaker/httparty

class PtxApiService
  include HTTParty
  base_uri 'https://ptx.transportdata.tw/MOTC/v2'
  headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'
  format :json

  def tra_station
    self.class.get('/Rail/TRA/Station?$top=10&$format=JSON', headers: authorization_headers).parsed_response
  end

  private

  def authorization_headers
    timestamp = Time.now.utc.strftime('%a, %d %b %Y %T GMT')
    hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', APP_KEY, "x-date: #{timestamp}"))

    return {
      'X-Date'        => timestamp,
      'Authorization' => %(hmac username="#{APP_ID}", algorithm="hmac-sha1", headers="x-date", signature="#{hmac}"),
    }
  end
end

response = PtxApiService.new.tra_station
# =>  [{"StationUID"=>"TRA-1001", ... }]
