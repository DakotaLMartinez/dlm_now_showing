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
  
  context "Adding a Showtime to a Movie" do
    describe "#add_showtime" do
      it "adds the showtime to the movie's showtimes collection" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        movie.add_showtime(showtime)
        
        expect(movie.showtimes).to include(showtime)
      end
      
      it "assigns the showtime to the movie" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        movie.add_showtime(showtime)
        
        expect(showtime.movie).to eq(movie)
      end
      
      it "does not assign the movie to the showtime if the showtime already has a movie" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.movie = movie
        
        expect(showtime).to_not receive(:movie=)
        
        movie.add_showtime(showtime)
      end
      
      it "does not add the showtime to the movie's showtimes collection if the movie already has the showtime inits collection" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        
        movie.add_showtime(showtime)
        movie.add_showtime(showtime)
        
        expect(movie.showtimes).to include(showtime)
        expect(movie.showtimes.size).to eq(1)
      end
    end
    
    describe "Showtime#movie=" do
      it "uses the Movie#add_showtime method to add the showtime to the movie's showtimes collection" do
        movie = Movie.new("Star Wars")
        showtime = Showtime.new("2015-12-28T18:30")
        
        expect(movie).to receive(:add_showtime)
        
        showtime.movie = movie
      end
    end
  end
  
  context "initializing a showtime with a movie" do
    it "new showtimes accept an optional argument for the movie" do
      movie = Movie.new("Star Wars")
      showtime = Showtime.new("2015-12-28T18:30", movie)
      
      expect(movie.showtimes).to include(showtime)
      expect(showtime.movie).to eq(movie)
    end
  end
end