require 'spec_helper'

describe "Showtimes and Genres" do 
  let!(:theatre) { Theatre.new(7793) }
  let!(:star_wars) { Movie.new("Star Wars",["Science fiction", "Adventure", "Fantasy", "Action"]) }
  let!(:sisters) { Movie.new("Sisters", ["Comedy"]) }
  let!(:good_dinosaur) { Movie.new("The Good Dinosaur", ["Comedy", "Animated", "Adventure"]) }
  let!(:comedy) { Genre.find_or_create_by_name("Comedy") }
  let!(:animated) { Genre.find_or_create_by_name("Animated") }
  let!(:adventure) { Genre.find_or_create_by_name("Adventure") }
  let!(:sci_fi) { Genre.find_or_create_by_name("Science fiction") }
  let!(:showtime1) { Showtime.new(good_dinosaur, "2015-12-28T18:30", theatre) }
  let!(:showtime2) { Showtime.new("2015-12-28T14:30") }
  let!(:showtime3) { Showtime.new("2015-12-28T12:00") }
  
  context "Showtimes have one or many genres through movies" do
    it "initializes with a genres property set to an empty array" do 
      expect(showtime1.genres).to eq([])
    end
    
    it "cannot push a genre into the showtime's theatre's collection" do 
      expect{ showtime1.genres << comedy}.to raise_error(RuntimeError)
    end
    
    describe "#add_genre" do
      it "adds a genre to the showtime's genres collection" do 
        showtime1.add_genre(comedy)
        expect(showtime1.genres).to include(comedy)
      end
    end
    
    describe "#genres" do 
      it "returns a list of the genres of the showtime's movie" do
        showtime1.movie = good_dinosaur
        showtime1.movie.genres.each do |genre|
          showtime1.add_genre(genre)
        end
        expect(showtime1.genres).to include(comedy, animated, adventure)
      end
      
      it "maintains uniqueness of genres" do
        
      end
    end
    
  end
  
end