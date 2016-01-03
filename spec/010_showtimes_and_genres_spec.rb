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
  let!(:showtime2) { Showtime.new(sisters, "2015-12-28T14:30", theatre) }
  let!(:showtime3) { Showtime.new(star_wars, "2015-12-28T12:00", theatre) }
  
  context "Showtime" do
    describe "#genres" do
      it "has many genres through movies" do 
        expect(showtime1.genres).to include(comedy, animated, adventure)
      end
      
      it "cannot push a genre into the showtime's theatres collection" do 
        expect{ showtime1.genres << comedy}.to raise_error(RuntimeError)
      end
    end
  end
  
  context "Genre" do
    describe "#showtimes" do 
      it "has many showtimes through movies" do 
        expect(comedy.showtimes).to include(showtime1, showtime2)
        expect(comedy.showtimes.size).to eq(2)
        expect(adventure.showtimes).to include(showtime1, showtime3)
        expect(adventure.showtimes.size).to eq(2)
      end
      
      it "cannot push a showtime directly into the genre's showtimes collection" do
        expect{ comedy.showtimes << Showtime.new(star_wars, "2015-12-28T18:00", theatre) }.to raise_error(RuntimeError)
      end
    end
  end
  
end