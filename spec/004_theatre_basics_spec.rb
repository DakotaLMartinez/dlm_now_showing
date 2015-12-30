require "spec_helper"

describe "Theatre Basics" do
  context "Theatre" do
    describe "#intialize" do 
      it "sets the id property of the theatre" do
        theatre = Theatre.new(7792)
        
        expect{Theatre.new(7792)}.to_not raise_error
        expect(theatre.id).to eq(7792)
      end
    end
    
    describe "#name" do
      it "sets the name property of the theatre" do
        theatre = Theatre.new(7792)
        theatre.name = "AMC Loews Marina 6"
        
        expect(theatre.name).to eq("AMC Loews Marina 6")
      end
    end
    
    describe ".all" do 
      it "returns the @@all class variable" do
        Theatre.class_variable_set(:@@all, [])
        
        expect(Theatre.all).to match_array([])
      end
    end
    
    describe ".destroy_all" do
      it "resets the class variable @@all to an empty array" do
        Theatre.class_variable_set(:@@all, ["Movie"])
        
        Theatre.destroy_all
        expect(Theatre.all).to match_array([])
      end
    end
    
    describe "#save" do 
      it "adds movie instances to the @@all class variable" do
        theatre = Theatre.new(7792)
        
        theatre.save
        
        expect(Theatre.all).to include(theatre)
      end
    end
    
    describe ".create" do
      it "initializes and saves the movie" do
        theatre = Theatre.create(7792)
        
        expect(Theatre.all).to include(theatre)
      end
    end
  end
end