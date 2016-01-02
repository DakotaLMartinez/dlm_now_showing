require 'spec_helper'
require 'pry'

describe "Theatres and Genres" do 
  let!(:star_wars) { Movie.new("Star Wars",["Science fiction", "Adventure", "Fantasy", "Action"]) }
  let!(:sisters) { Movie.new("Sisters", ["Comedy"]) }
  let!(:good_dinosaur) { Movie.new("The Good Dinosaur", ["Comedy", "Animated", "Adventure"]) }
  let!(:sci_fi) { Genre.find_or_create_by_name("Science fiction") }
  let!(:fantasy) { Genre.find_or_create_by_name("Fantasy") }
  let!(:adventure) { Genre.find_or_create_by_name("Adventure") }
  let!(:action) { Genre.find_or_create_by_name("Action") }
  let!(:comedy) { Genre.find_or_create_by_name("Comedy") }
  let!(:animated) { Genre.find_or_create_by_name("Animated") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:theatre2) { Theatre.new(11072) }
  let(:theatre3) { Theatre.new(8827) }
  let!(:showtime1) { Showtime.new(star_wars, "2015-12-28T18:30", theatre2) }
  let!(:showtime2) { Showtime.new(sisters, "2015-12-28T18:00", theatre2) }
  let!(:showtime3) { Showtime.new(sisters, "2015-12-28T18:00", theatre3) }
  let!(:showtime4) { Showtime.new(good_dinosaur, "2015-12-28T18:30", theatre3) }
  
  context "Theatres have many genres of movies through showtimes" do
    it "initializes with a genres property set to an empty array" do 
      expect(theatre1.movies).to eq([])  
    end
    
    it "cannot push a genre directly into the theatre's genres collection" do 
      expect{theatre1.genres << comedy}.to raise_error(RuntimeError)
    end
    
    # describe "#add_genre" do 
    #   it "adds a genre to the theatre's genres collection" do 
    #     expect(theatre2.genres).to include(comedy)
    #   end
    # end
    
    describe "#genres" do
      it "returns a list of all the genres of movies playing at a given theatre" do
        showtime1.save
        showtime2.save
        expect(theatre2.genres).to include(sci_fi, fantasy, adventure, action, comedy)
        Showtime.destroy_all
      end
      
      it "maintains uniqueness of genres" do 
        showtime3.save
        showtime4.save
        expect(theatre3.genres).to include(comedy, adventure, animated)
        expect(theatre3.genres.size).to eq(3)
        Showtime.destroy_all
      end
      
    end
  end
  
  context "Genres have many theatres through movies thorugh showtimes" do
    it "genres initialize with a theatres property set to an empty array" do 
      horror = Genre.new("Horror")
      expect(horror.theatres).to eq([])
    end
    
    describe "#theatres" do
      it "returns a list of theatres that are playing movies of a given genre" do
        expect(comedy.theatres).to include(theatre2, theatre3)
      end
      
      it "maintains uniqueness of theatres" do 
        new_showtime = Showtime.new(good_dinosaur, "2015-12-28T16:00", theatre2)
        
        expect(comedy.theatres.size).to eq(2)
      end
    end
  end
end