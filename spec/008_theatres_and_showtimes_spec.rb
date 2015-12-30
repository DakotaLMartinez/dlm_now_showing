require 'spec_helper'

describe "Theatres and Showtimes" do
  let!(:star_wars) { Movie.new("Star Wars") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:showtime1) { Showtime.new("2015-12-28T18:30").theatre = theatre1 }
  let!(:theatre2) { Theatre.new(11006) }
  let!(:showtime2) { Showtime.new("2015-12-28T14:30").theatre = theatre2 }
  let!(:showtime3) { Showtime.new("2015-12-28T12:00").theatre = theatre2 }
  
  context "Theatre" do
    it "initializes with a showtimes property set to an empty array" do
      expect(theatre1.showtimes).to eq([])
    end
    
    describe "#showtimes" do
      it "has many showtimes" do
        theatre1.add_showtime(showtime1)
        theatre1.add_showtime(showtime2)
        
        expect(theatre1.showtimes).to include(showtime1, showtime2)
      end
    end
    
    describe "#add_showtime" do 
      it "adds a showtime to the theatre's showtimes collection" do
        theatre1.add_showtime(showtime1)
        
        expect(theatre1.showtimes).to include(showtime1)
      end
      
      it "tells the showtime that it belongs to the theatre" do 
        theatre1.add_showtime(showtime1)
        
        expect(showtime1.theatre).to eq(theatre1)
      end
      
      it "does not add a showtime to a theatre's showtimes collection if it already exists within the collection" do 
        theatre1.add_showtime(showtime1)
        theatre1.add_showtime(showtime1)
      
        expect(theatre1.showtimes.size).to eq(1)
      end
      
      it "does not assign the theatre to the showtime if the showtime already has a theatre assigned" do
        showtime1.theatre = theatre1
        
        expect(theatre1).to_not receive(:add_showtime)
      end
    end
  end
  
  context "Showtime" do
    describe "#theatre=" do
      it "adds the showtime to the theatre's showtimes collection" do
        showtime1.theatre = theatre1
        
        expect(theatre1.showtimes).to include(showtime1)
      end
    end
  end
  
  context "initializing a Showtime with a Theatre" do 
    describe "Showtime" do 
      it "accepts an optional argument for Theatre upon instantiation" do 
        theatre = Theater.new(7793)
        showtime = Showtime.new("2015-12-28T18:30", theatre)
        
        expect(showtime.theatre).to eq(theatre)
        expect(theatre.showtimes).to include(showtime)
      end
    end
  end
end