require 'spec_helper'

describe "Movie Basics" do
  context Movie do
    describe "#initialize with @title" do
      it 'accepts a title for the movie' do
        star_wars = Movie.new("Star Wars")
        expect(star_wars.title).to eq("Star Wars")
      end
    end
    
    describe "#title=" do
      it "sets the title of the movie" do
        star_wars = Movie.new("Star Wars")
        star_wars.title = "Star Wars: A New Hope"
        
        expect(star_wars.title).to eq("Star Wars: A New Hope")
      end
    end
    
    describe ".all" do 
      it "returns the @@all class variable" do
        Movie.class_variable_set(:@@all, [])
        
        expect(Movie.all).to match_array([])
      end
    end
    
    describe ".destroy_all" do
      it "resets the class variable @@all to an empty array" do
        Movie.class_variable_set(:@@all, ["Movie"])
        
        Movie.destroy_all
        expect(Movie.all).to match_array([])
      end
    end
    
    describe "#save" do 
      it "adds movie instances to the @@all class variable" do
        star_wars = Movie.new("Star Wars")
        
        star_wars.save
        
        expect(Movie.all).to include(star_wars)
      end
    end
    
    describe ".create" do
      it "initializes and saves the movie" do
        star_wars = Movie.create("Star Wars")
        
        expect(Movie.all).to include(star_wars)
      end
    end
  end
end