require "spec_helper"

context "MovieShowingsController" do 
  let!(:movie_showings_controller) { MovieShowingsController.new }
  let!(:movie_importer) { MovieImporter.new("http://dakotaleemartinez.com/movie-data-for-test.json") }
  describe "#initialize" do 
    it "initializes with a searches property set to an empty array" do 
      expect{MovieShowingsController.new.searches}.to eq([])
    end
    
    it "the url argument defaults to 'http://dakotaleemartinez.com/movie-data-for-test.json'" do 
      expect(MovieImporter).to receive(:new).with('http://dakotaleemartinez.com/movie-data-for-test.json').and_return(MovieImporter)
    end
  end
  
  describe "#get_zip_code" do 
    it "asks the user to input a zip code to search for movies" do 
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      movie_showings_controller.get_zip_code
      
      expect(movie_showings_controller.zip_code.length).to eq(5)
      expect(movie_showings_controller.zip_code.to_i).to be_a(Integer)
    end
  end
  
  describe "#get_search_radius" do 
    it "asks the user to confirm the default radius of 5 miles or enter a new one between 1 and 100 miles" do 
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      movie_showings_controller.get_search_radius
      search_radius = movie_showings_controller.search_radius
      
      expect(search_radius).to be_a(Integer)
      expect(search_radius).to be_between(1, 100).inclusive
    end
  end
  
  describe "#get_showing_date" do 
    it "asks the user to confirm the default showing date of today's date or enter a new one in the format 2016-01-10" do
      expect(movie_showings_controller).to receive(:gets).and_return("exit")
      movie_showings_controller.get_showing_date
      showing_date = movie_showings_controller.showing_date
      
      expect(showing_date).to match(/\d{4}-\d{2}-\d{2}/)
      expect(Date.parse showing_date).to be_a(Date)
    end
  end
  
  describe "#call" do 
    it "responds to a call method to start the CLI" do 
      expect(movie_showings_controller).to respond_to(:call)
    end
    
    
    context "#return_on_exit" do 
      it "stops the program if the user types in 'exit'" do 
        expect(movie_showings_controller).to receive(:gets).and_return("exit")
      end
    end
    
  end
end