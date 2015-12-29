require 'spec_helper'

describe "Movies and Theatres" do
  let!(:star_wars) { Movie.new("Star Wars") }
  let!(:sisters) { Movie.new("Sisters") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:showtime1) { Showtime.new("2015-12-28T18:30").theatre = theatre1 }
  let!(:theatre2) { Theatre.new(11006) }
  let!(:showtime2) { Showtime.new("2015-12-28T14:30").theatre = theatre2 }
  let!(:showtime3) { Showtime.new("2015-12-28T12:00").theatre = theatre2 }
  
  context "Movie" do
    it "initializes with a theatres property set to an empty array" do
      expect(star_wars.theatres).to eq([])
    end
    
    describe "#theatres" do
      it "has many theatres through showtimes (only stores unique theatres)" do
        star_wars.add_showtime(showtime1)
        star_wars.add_showtime(showtime2)
        star_wars.add_showtime(showtime3)
        
        expect(movie.theatres).to include(theatre1)
        expect(movie.theatres).to include(theatre2)
        expect(movie.theatres.size).to eq(2)
      end
    end
  end
  
  context "Theatre" do
    it "initializes with a movies property set to an empty array" do
      expect(theatre1.movies).to eq([])
    end
    
    describe "#movies" do
      it "has many movies through showtimes" do
        
      end
    end
  end
end