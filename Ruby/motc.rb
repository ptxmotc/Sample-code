require 'time'
require 'json'
require "base64"
require 'openssl'
require 'net/http'

class MOTC
  def initialize(app_id, app_key, version = "/v2")
      @id = app_id
      @key = app_key
      @base_url = "http://ptx.transportdata.tw/MOTC#{version}"
  end

  def get(route)
    uri = URI.parse(@base_url + route)
    req = Net::HTTP::Get.new(uri)

    req['x-date'] = x_date
    req['Authorization'] = authorization

    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    JSON.parse(res.body)
  end

  private

    def authorization
      hmac =  Base64.encode64(OpenSSL::HMAC.digest('sha1', @key, "x-date: #{x_date}")).sub("\n", "")
      "hmac username=\"#{@id}\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"#{hmac}\""
    end

    def x_date
      Time.now.httpdate
    end     
end
