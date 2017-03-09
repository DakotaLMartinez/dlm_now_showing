# require "dlm_now_showing/version"
require 'pry'

module DlmNowShowing
  class RequestUrl
    attr_reader :url
    def initialize(zip_code,radius="5", start_date=Time.now.strftime("%Y-%m-%d"))
       raise NameError, 'Remember to add your gracenote OnConnect API_KEY to .env file. Visit: http://developer.tmsapi.com/member/register to register and get your API key.' unless ENV['API_KEY']
       @url = "http://data.tmsapi.com/v1.1/movies/showings?startDate=#{start_date}&zip=#{zip_code.to_s}&radius=#{radius.to_s}&api_key=#{ENV['API_KEY']}" 
    end
  end
  
  class MovieImporter
    attr_reader :response
    def initialize(url)
      @response = HTTParty.get(url).parsed_response
    end
    
    def import
      self.response.each do |movie|
        title = movie["title"]
        genres = movie["genres"]
        showtimes = movie["showtimes"]
        
        this_movie = Movie.find_or_create_by_title(title,genres)
        
        showtimes.each do |showtime|
          theatre_id = showtime["theatre"]["id"]
          theatre_name = showtime["theatre"]["name"]
          time = showtime["dateTime"]
          theatre = Theatre.find_or_create_by_id_and_name(theatre_id, theatre_name)
          Showtime.find_or_create_by_movie_time_and_theatre(this_movie, time, theatre)
        end
        
      end
      # binding.pry
    end
  end
  
  class MovieShowingsController
    attr_reader :searches, :zip_code, :search_radius, :showing_date
    def initialize
      @searches = []
    end
  end
end
