require "spec_helper"

context "MovieShowingsController" do 
  let!(:movie_showings_controller) { MovieShowingsController.new }
  let!(:movie_importer) { DlmNowShowing::MovieImporter.new("http://dakotaleemartinez.com/movie-data-for-test.json") }
  describe "#initialize" do 
    it "initializes with a searches property set to an empty array" do 
      expect(MovieShowingsController.new.searches).to eq([])
    end
    
    # it "the url argument defaults to 'http://dakotaleemartinez.com/movie-data-for-test.json'" do 
    #   expect(MovieImporter).to receive(:new).with('http://dakotaleemartinez.com/movie-data-for-test.json').and_return(MovieImporter)
    # end
  end
  
  describe "#get_zip_code" do 
    it "asks the user to input a zip code to search for movies" do 
      expect(movie_showings_controller).to receive(:gets).and_return(90066)
      zip_code = movie_showings_controller.get_zip_code
      
      expect(zip_code).to eq("90066")
      expect(zip_code.to_i).to be_a(Integer)
    end
    
    it "allows user to exit inteface with the 'exit' command" do 
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      zip_code = movie_showings_controller.get_zip_code
    end
  end
  
  describe "#get_search_radius" do 
    it "asks the user to confirm the default radius of 5 miles or enter a new one between 1 and 100 miles" do 
      expect(movie_showings_controller).to receive(:gets).and_return("150","50")
      search_radius = movie_showings_controller.get_search_radius
      
      expect(search_radius.to_i).to eq(50)
      # expect(search_radius.to_i).to be_between(1, 100).inclusive
    end
    
    it "returns 5 if the user enters an empty string" do 
      expect(movie_showings_controller).to receive(:gets).and_return("")
      search_radius = movie_showings_controller.get_search_radius
      
      expect(search_radius).to eq("5")
    end
    
    it "allows the user to exit interface with the 'exit' command" do 
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      movie_showings_controller.get_search_radius
    end
  end
  
  describe "#get_showing_date" do 
    it "asks the user to confirm the default showing date of today's date or enter a new one in the format #{(Time.now+172800).strftime("%Y-%m-%d")}" do
      expect(movie_showings_controller).to receive(:gets).and_return("2016-01-10")
      showing_date = movie_showings_controller.get_showing_date
      
      expect(showing_date).to match(/\d{4}-\d{2}-\d{2}/)
      expect(Date.parse showing_date).to be_a(Date)
    end
    
    it "returns today's date if the user enters an empty string" do 
      expect(movie_showings_controller).to receive(:gets).and_return("")
      showing_date = movie_showings_controller.get_showing_date
      
      expect(showing_date).to eq(Time.now.strftime("%Y-%m-%d"))
    end
    
    it "allows the user to exit interface with the 'exit' command" do 
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      movie_showings_controller.get_showing_date
    end
  end
  
  describe "#call" do 
    it "responds to a call method to start the CLI" do 
      expect(movie_showings_controller).to respond_to(:call)
    end
    
    it "accepts an optional argument for request url allowing the method to accept a url for test data" do 
      expect(DlmNowShowing::MovieImporter).to receive(:new).with("http://dakotaleemartinez.com/movie-data-for-test.json").and_return(DlmNowShowing::MovieImporter.new("http://dakotaleemartinez.com/movie-data-for-test.json"))
    end
    
  end
end