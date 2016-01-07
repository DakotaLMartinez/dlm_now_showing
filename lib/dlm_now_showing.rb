# require "dlm_now_showing/version"
require 'pry'

module DlmNowShowing
  class RequestUrl
    attr_reader :url
    def initialize(zip_code)
       @url = "http://data.tmsapi.com/v1.1/movies/showings?startDate=#{Time.now.strftime("%Y-%m-%d")}&zip=#{zip_code.to_s}&api_key=#{ENV['API_KEY']}" 
    end
  end
  
  class MovieImporter
    attr_reader :response
    def initialize(url)
      @response = HTTParty.get(url).parsed_response
    end
  end
end
