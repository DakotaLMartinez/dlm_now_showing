require 'spec_helper'

describe "Movies and Theatres" do
  let!(:star_wars) { Movie.new("Star Wars") }
  let!(:sisters) { Movie.new("Sisters") }
  let!(:big_short) { Movie.new("The Big Short") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:theatre2) { Theatre.new(11006) }
  let!(:theatre3) { Theatre.new(18234) }
  let!(:showtime1) { Showtime.new(star_wars, "2015-12-28T18:30", theatre1) }
  let!(:showtime2) { Showtime.new(star_wars, "2015-12-28T14:30", theatre2) }
  let!(:showtime3) { Showtime.new(star_wars, "2015-12-28T12:00", theatre2) }
  let!(:showtime4) { Showtime.new(big_short, "2015-12-28-T18:00", theatre2) }
  
  context "Movie" do
    it "initializes with a theatres property set to an empty array" do
      expect(sisters.theatres).to eq([])
    end
    
    describe "#theatres" do
      it "has many theatres through showtimes (only stores unique theatres)" do
        expect(star_wars.theatres).to include(theatre1, theatre2)
        expect(star_wars.theatres.size).to eq(2)
      end
    end
  end
  
  context "Theatre" do
    it "initializes with a movies property set to an empty array" do
      expect(theatre3.movies).to eq([])
    end
    
    describe "#movies" do
      it "has many movies through showtimes (no duplicate movies)" do
        
        expect(theatre2.movies).to include(star_wars, big_short)
        expect(theatre2.movies.size).to eq(2)
      end
    end
  end
end