require 'pry'
require "spec_helper"

context "ResquestURL" do 
  describe "#initialize" do 
    it "accepts a zip code and returns a url containing json movie data" do 
      expect(DlmNowShowing::RequestUrl.new(90066).url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{Time.now.strftime("%Y-%m-%d")}&zip=90066&api_key=#{ENV['API_KEY']}")
      binding.pry
    end
    
    it "accepts optional arguments for start date and radius" do 
      expect(DlmNowShowing::RequestUrl.new(90066,2016-01-10,10).url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=2016-01-10&zip=78701&radius=10&api_key=#{ENV['API_KEY']}")
    end
  end
end