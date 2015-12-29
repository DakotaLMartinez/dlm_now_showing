require 'spec_helper'

describe "Showtime Basics" do
  context Showtime do
    describe "#initialize" do
      it "accepts a time for the showtime" do
        showtime = Showtime.new("2015-12-28T18:30")
        
        expect(showtime.time).to eq("2015-12-24T10:45")
      end
    end
    
    describe "#theatre=" do
      it "sets the theatre of the showtime" do
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.theatre = "AMC Loews Marina 6"
        
        expect(showtime.theatre).to eq("AMC Loews Marina 6")
      end
    end
    
    describe "#movie=" do
      it "sets the movie that the showtime belongs to" do
        showtime = Showtime.new("2015-12-28T18:30")
        movie = Movie.new("Sisters")
        showtime.movie = movie
        
        expect(showtime.movie).to eq(movie)
      end
    end
    
    describe "#details=" do
      it "sets the details of the showtime" do
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.details = "No one under 18 admitted|Cinema Suites|Dine-In|Reserved Seating|Descriptive Video Services|Closed Captioned"
        
        expect(showtime.details).to eq("No one under 18 admitted|Cinema Suites|Dine-In|Reserved Seating|Descriptive Video Services|Closed Captioned")
      end
    end
    
    describe "#discount?" do
      it "tells whether the showtime is a discount or not" do
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.discount = true
        
        expect(showtime.discount?).to be_truthy
      end
    end
    
    describe "#ticket_url=" do
      it "sets the url where tickets can be purchased" do
        showtime = Showtime.new("2015-12-28T18:30")
        showtime.ticket_url = "http://www.fandango.com/tms.asp?t=AAAXA&m=151583&d=2015-12-28"
        
        expect(showtime.ticket_url).to eq("http://www.fandango.com/tms.asp?t=AAAXA&m=151583&d=2015-12-28")
      end
    end
    
    describe ".all" do 
      it "returns the @@all class variable" do
        Showtime.class_variable_set(:@@all, [])
        
        expect(Showtime.all).to match_array([])
      end
    end
    
    describe ".destroy_all" do
      it "resets the class variable @@all to an empty array" do
        Showtime.class_variable_set(:@@all, ["Movie"])
        
        Showtime.destroy_all
        expect(Showtime.all).to match_array([])
      end
    end
    
    describe "#save" do 
      it "adds showtime instances to the @@all class variable" do
        showtime = Showtime.new("2015-12-28T18:30")
        
        showtime.save
        
        expect(Showtime.all).to include(showtime)
      end
    end
    
    describe ".create" do
      it "initializes and saves the showtime" do
        showtime = Showtime.create("2015-12-28T18:30")
        
        expect(Showtime.all).to include(showtime)
      end
    end
  end
end