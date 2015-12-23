# require "dlm_now_showing/version"
require 'pry'

module DlmNowShowing
  class GetRequestUrl
    attr_reader :url
    def initialize(zip_code)
       @url = "http://data.tmsapi.com/v1.1/movies/showings?startDate=#{Time.now.strftime("%Y-%m-%d")}&zip=#{zip_code.to_s}&api_key=ju2ketuuttqvsch9jzjstbn8" 
    end
  end
end
