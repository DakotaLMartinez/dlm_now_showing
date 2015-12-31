require 'pry'
require 'spec_helper'

describe "Movies and Genres" do
  let!(:comedy) { Genre.new("Comedy") }
  let!(:sisters) { Movie.new("Sisters") }
  context "Genres have many movies" do
    it "initializes with a movies property set to an empty array" do
      expect(comedy.movies).to eq([])
    end
    
    it "cannot push a movie directly into the genre's movie collection" do
      expect{comedy.movies << sisters}.to raise_error(RuntimeError)
    end
    describe "#add_movie" do 
      it "adds a movie to the genre's movie collection" do 
        comedy.add_movie(sisters)
        expect(comedy.movies).to include(sisters)
      end
    end
    describe "#movies" do
      it "returns the array of movies belonging to a genre" do 
        comedy.add_movie(sisters)
        expect(comedy.movies).to eq([sisters])
      end
    end
  end
  
  context "Movies have one or many genres" do
    it "initializes with a genres property set to an empty array" do
      expect(sisters.genres).to eq([])
    end
    
    it "cannot push a genre directly into the movie's genre collection" do
      expect{sisters.genres << comedy}.to raise_error(RuntimeError)
    end
    
    describe "#add_genre" do
      it "accepts a genre for a movie" do
        sisters.add_genre(comedy)
        
        expect(sisters.genres).to include(comedy)
        expect(sisters.genres.size).to eq(1)
      end
      
      it "adds the movie to the genre's movie collection" do
        sisters.add_genre(comedy)
        
        expect(comedy.movies).to include(sisters)
        expect(comedy.movies.size).to eq(1)
      end
      
      it "does not add the movie to the genre's movie collection if it already exists within the collection" do
        sisters.add_genre(comedy)
        sisters.add_genre(comedy)
        
        expect(comedy.movies).to include(sisters)
        expect(comedy.movies.size).to eq(1)
      end
      
      it "does not add the genre to the movie's genres collection if it already exists within the collection" do
        sisters.add_genre(comedy)
        sisters.add_genre(comedy)
        
        expect(sisters.genres).to include(comedy)
        expect(sisters.genres.size).to eq(1)
      end
    end
  end
  
  context "initializing a movie with genres" do
    it "new movies accept an optional argument for genres as an array of strings" do
      genres = ["Adventure", "Historical drama", "Action"]
      movie = Movie.new("In the Heart of the Sea", genres)
      genre_objects = genres.collect { |genre| Genre.find_or_create_by_name(genre) }
      
      expect(movie.genres).to eq(genre_objects)
      genre_objects.each do |genre|
        expect(movie.genres).to include(genre)
        expect(genre.movies).to include(movie)
      end
    end
  end
end