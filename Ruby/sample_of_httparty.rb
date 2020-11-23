APP_ID = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'
APP_KEY = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'

require 'httparty' # https://github.com/jnunemaker/httparty

class PtxApiService
  include HTTParty
  base_uri 'https://ptx.transportdata.tw/MOTC/v2'
  format :json

  headers(
    'Content-Type'  => 'application/json',
    'Accept'        => 'application/json',
    'X-Date'        => ->{ @current_timestamp = Time.now.utc.strftime('%a, %d %b %Y %T GMT') },
    'Authorization' => ->{ authorization_header },
  )

  class << self
    def authorization_header
      hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', APP_KEY, "x-date: #{@current_timestamp}"))
      return %(hmac username="#{APP_ID}", algorithm="hmac-sha1", headers="x-date", signature="#{hmac}")
    end
  end

  def daily_time_table(date)
    self.class.get("/Rail/THSR/DailyTimetable/TrainDate/#{date.strftime('%F')}?$top=1&$format=JSON").parsed_response
  end

  def tra_station
    self.class.get('/Rail/TRA/Station?$top=1&$format=JSON').parsed_response
  end
end

response1 = PtxApiService.new.daily_time_table(Date.new(2020, 11, 12))
# => [{"TrainDate"=>"2020-11-12", ... }]

response2 = PtxApiService.new.tra_station
# => [{"StationUID"=>"TRA-1001", ... }]
