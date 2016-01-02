require 'pry'
require 'spec_helper'

describe "Theatres and Showtimes" do
  let!(:star_wars) { Movie.new("Star Wars") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:theatre2) { Theatre.new(11006) }
  let!(:theatre3) { Theatre.new(8302) }
  let!(:showtime1) { Showtime.create(star_wars, "2015-12-28T18:30", theatre2) }
  let!(:showtime2) { Showtime.create(star_wars, "2015-12-28T14:30", theatre2) }
  let!(:showtime3) { Showtime.create(star_wars, "2015-12-28T12:00", theatre2) }
  let!(:showtime4) { Showtime.create(star_wars, "2015-12-28T18:30", theatre3) }
  
  context "Theatre" do
    describe "#showtimes" do
      it "returns a list of the showtimes playing at the theatre" do
        expect(theatre2.showtimes).to include(showtime1, showtime2, showtime3)
      end
    end
    
    # describe "#add_showtime" do 
    #   it "adds a showtime to the theatre's showtimes collection" do
    #     theatre1.add_showtime(showtime1)
        
    #     expect(theatre1.showtimes).to include(showtime1)
    #   end
      
    #   it "tells the showtime that it belongs to the theatre" do 
    #     expect(showtime4.theatre).to eq(theatre3)
    #   end
      
    #   it "does not add a showtime to a theatre's showtimes collection if it already exists within the collection" do 
    #     theatre1.add_showtime(showtime1)
    #     theatre1.add_showtime(showtime1)
    #     theatre2.add_showtime(showtime1)
      
    #     expect(theatre1.showtimes.size).to eq(1)
    #   end
      
    #   it "does not assign the theatre to the showtime if the showtime already has a theatre assigned" do
    #     showtime1.theatre = theatre1
        
    #     expect(theatre1).to_not receive(:add_showtime)
    #   end
    # end
  end
  
  context "Showtime" do
    describe "#theatre" do
      it "returns the theatre at which the showtime is playing" do
        expect(showtime2.theatre).to eq(theatre2)
      end
    end
  end
  
  # context "initializing a Showtime with a Theatre" do 
  #   describe "Showtime" do 
  #     it "accepts an optional argument for Theatre upon instantiation" do 
  #       theatre = Theater.new(7793)
  #       showtime = Showtime.new("2015-12-28T18:30", theatre)
        
  #       expect(showtime.theatre).to eq(theatre)
  #       expect(theatre.showtimes).to include(showtime)
  #     end
  #   end
  # end
end