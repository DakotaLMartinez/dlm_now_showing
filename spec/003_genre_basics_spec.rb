require 'spec_helper'

describe "Genre Basics" do
  context Genre do
    describe "#initialize" do
      it "sets the name of the genre" do
        genre = Genre.new("Comedy") 
        
        expect(genre.name).to eq("Comedy")
      end
    end
    
    describe ".all" do 
      it "returns the @@all class variable" do
        Genre.class_variable_set(:@@all, [])
        
        expect(Genre.all).to match_array([])
      end
    end
    
    describe ".destroy_all" do
      it "resets the class variable @@all to an empty array" do
        Genre.class_variable_set(:@@all, ["Movie"])
        
        Genre.destroy_all
        expect(Genre.all).to match_array([])
      end
    end
    
    describe "#save" do 
      it "adds movie instances to the @@all class variable" do
        comedy = Genre.new("Comedy")
        
        comedy.save
        
        expect(Genre.all).to include(comedy)
      end
    end
    
    describe ".create" do
      it "initializes and saves the movie" do
        comedy = Genre.create("Comedy")
        
        expect(Genre.all).to include(comedy)
      end
    end
  end
end