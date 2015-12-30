require 'spec_helper'

describe "Theatres and Genres" do 
  let!(:star_wars) { Movie.new("Star Wars",["Science fiction", "Adventure", "Fantasy", "Action"]) }
  let!(:sisters) { Movie.new("Sisters", ["Comedy"]) }
  let!(:good_dinosaur) { Movie.new("The Good Dinosaur", ["Comedy", "Animated", "Adventure"]) }
  let!(:comedy) { Genre.new("Comedy") }
  let!(:theatre1) { Theatre.new(7792) }
  let!(:showtime1) { Showtime.new("2015-12-28T18:30") }
  
  context "Theatres have many genres of movies through showtimes" do
    it "initializes with a genres broperty set to an empty array" do 
      expect(theatre1.movies).to eq([])  
    end
    
    it "cannot push a genre directly into the theatre's genres collection" do 
      expect(theatre1.genres << comedy).to raise_error
    end
    
    describe "#add_genre" do 
      it "adds a genre to the theatre's genres collection" do 
        theatre1.add_genre(comedy)
        expect(theatre1.genres).to include(comedy)
      end
    end
    
    describe "#genres" do
      it "returns a list of all the genres of movies playing at a given theatre" do
        theatre1.add_showtime(showtime1).movie = star_wars
        theatre1.add_showtime(showtime1).movie = sisters
        genres = ["Science fiction", "Adventure", "Fantasy", "Action", "Comedy"]
        genre_objects = genres.collect { |genre| Genre.new(genre) }
        
        genre_objects.each do |genre|
          expect(theatre1.genres).to include(genre)
        end
      end
      
      it "maintains uniqueness of genres" do 
        theater1.add_showtime(showtime1).movie = sisters
        theater1.add_showtime(showtime2).movie = good_dinosaur
        
        genres = ["Comedy", "Animated", "Adventure"]
        genre_objects = genres.collect { |genre| Genre.new(genre) }
        genre_objects.each do |genre|
          expect(theatre1.genres).to include(genre)
        end
        expect(theatre1.genres.size).to eq(3)
      end
      
    end
  end
  
  context "Genres have many theatres through movies thorugh showtimes" do
    it "genres initialize with a theatres property set to an empty array" do 
      expect(comedy.theatres).to eq([])
    end
    
    describe "#theatres" do
      it "returns a list of theatres that are playing movies of a given genre" do
        theatre1.add_showtime(showtime1).movie = sisters
        theatre2.add_showtime(showtime2).movie = sisters
        
        expect(comedy.theatres).to include(theatre1, theatre2)
      end
      
      it "maintains uniqueness of theatres" do 
        theatre1.add_showtime(showtime1).movie = sisters
        theatre1.add_showtime(showtime2).movie = sisters
        
        expect(comedy.theatres).to include(theatre1)
        expect(comedy.theatres.size).to eq(1)
      end
    end
  end
end