require 'spec_helper'

describe "Movies and Showtimes" do
  context "Movies have many Showtimes" do
    it "#initializes with a showtimes property set to an empty array" do
      movie = Movie.new("Star Wars")
      
      expect(movie.showtimes).to eq([])
    end
    
    it "cannot add a showtime directly into the showtimes collection" do
      movie = Movie.new("Star Wars")
      showtime = Showtime.new("2015-12-28T18:30")
      
      expect(movie.showtimes << showtime).to raise_error
    end
  end
  
  context "Showtimes belong to a Movie" do
    describe "#movie=" do
      it "accepts a movie for the showtime" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.movie = movie
        
        expect(showtime.movie).to eq(movie)
      end
      
      it "adds the showtime to the movie's showtimes collection" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.movie = movie
        
        expect(movie.showtimes).to include(showtime)
      end
    end
  end
end