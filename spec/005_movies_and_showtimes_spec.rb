require 'pry'
require 'spec_helper'

describe "Movies and Showtimes" do
  let!(:sisters) { Movie.new("Sisters") }
  let!(:star_wars) { Movie.new("Star Wars") }
  let!(:theatre) { Theatre.new(7793) }
  let!(:showtime) { Showtime.new(star_wars, "2015-12-28T18:30", theatre) }
  
  context "Movies have many Showtimes" do
    it "#initializes with a showtimes property set to an empty array" do
      expect(sisters.showtimes).to eq([])
    end
    
    it "cannot add a showtime directly into the showtimes collection" do
      expect{star_wars.showtimes << showtime}.to raise_error(RuntimeError)
    end
    
    describe "#showtimes" do
      it "returns an array of showtimes of the given movie" do 
        star_wars.add_showtime(showtime)
        expect(star_wars.showtimes).to include(showtime)
      end
    end
  end
  
  context "Showtimes belong to a Movie" do
    describe "#movie=" do
      it "accepts a movie for the showtime" do
        expect(showtime.movie).to eq(star_wars)
      end
      
      it "adds the showtime to the movie's showtimes collection" do
        expect(star_wars.showtimes).to include(showtime)
      end
    end
  end
  
  context "Movies -- adding showtimes" do
    describe "#add_showtime" do
      it "adds the showtime to the movie's showtimes collection" do
        star_wars.add_showtime(showtime)
        
        expect(star_wars.showtimes).to include(showtime)
      end
      
      it "assigns the showtime to the movie" do
        star_wars.add_showtime(showtime)
        
        expect(showtime.movie).to eq(star_wars)
      end
      
      it "does not assign the movie to the showtime if the showtime already has a movie" do
        showtime.movie = star_wars
        
        expect(showtime).to_not receive(:movie=)
        
        star_wars.add_showtime(showtime)
      end
      
      it "does not add the showtime to the movie's showtimes collection if the movie already has the showtime in its collection" do
        star_wars.add_showtime(showtime)
        star_wars.add_showtime(showtime)
        
        expect(star_wars.showtimes).to include(showtime)
        expect(star_wars.showtimes.size).to eq(1)
      end
    end
    
    context "Showtime" do
      describe "#movie=" do
        it "accepts a movie for the showtime" do
          expect(showtime.movie).to eq(star_wars)
        end
        
        it "adds the showtime to the movie's showtimes collection" do
          expect(star_wars.showtimes).to include(showtime)
        end
        it "uses the Movie#add_showtime method to add the showtime to the movie's showtimes collection" do
          expect(star_wars).to receive(:add_showtime)
          
          showtime.movie = star_wars
        end
      end
    end
  end
  
  # context "initializing a showtime with a movie" do
  #   it "new showtimes accept an optional argument for the movie" do
  #     new_showtime = Showtime.new("2015-12-28T18:30", star_wars)
      
  #     expect(star_wars.showtimes).to include(new_showtime)
  #     expect(new_showtime.movie).to eq(star_wars)
  #   end
  # end
end