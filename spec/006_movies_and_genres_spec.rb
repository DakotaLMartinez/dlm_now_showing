require 'spec_helper'

describe "Movies and Genres" do
  context "Genres have many movies" do
    it "initializes with a movies property set to an empty array" do
      genre = Genre.new("Comedy")
      
      expect(genre.movies).to eq([])
    end
    
    it "cannot push a movie directly into the genre's movie collection" do
      genre = Genre.new("Comedy")
      movie = Movie.new("Sisters")
      
      expect(genre.movies << movie).to raise_error
    end
  end
  
  context "Movies have one or many genres" do
    it "initializes with a genres property set to an empty array" do
      movie = Movie.new("Sisters")
      
      expect(movie.genres).to eq([])
    end
    
    it "cannot push a genre directly into the movie's genre collection" do
      genre = Genre.new("Comedy")
      movie = Movie.new("Sisters")
      
      expect(movie.genres << genre).to raise_error
    end
    
    describe "#add_genre" do
      it "accepts a genre for a movie" do
        genre = Genre.new("Comedy")
        movie = Movie.new("Sisters")
        
        movie.add_genre(genre)
        
        expect(movie.genres).to include(genre)
        expect(movie.genres.size).to eq(1)
      end
      
      it "adds the movie to the genre's movie collection" do
        genre = Genre.new("Comedy")
        movie = Movie.new("Sisters")
        
        movie.add_genre(genre)
        
        expect(genre.movies).to include(movie)
        expect(genre.movies.size).to eq(1)
      end
      
      it "does not add the movie to the genre's movie collection if it already exists within the collection" do
        genre = Genre.new("Comedy")
        movie = Movie.new("Sisters")
        
        movie.add_genre(genre)
        movie.add_genre(genre)
        
        expect(genre.movies).to include(movie)
        expect(genre.movies.size).to eq(1)
      end
      
      it "does not add the genre to the movie's genres collection if it already exists within the collection" do
        genre = Genre.new("Comedy")
        movie = Movie.new("Sisters")
        
        movie.add_genre(genre)
        movie.add_genre(genre)
        
        expect(movie.genres).to include(genre)
        expect(movie.genres.size).to eq(1)
      end
    end
  end
  
  context "initializing a movie with genres" do
    it "new movies accept an optional argument for genres as an array of strings" do
      genres = ["Adventure", "Historical drama", "Action"]
      movie = Movie.new("In the Heart of the Sea", genres)
      genre_objects = genres.collect { |genre| Genre.new(genre) }
      
      expect(movie.genres).to eq(genre_objects)
      genre_objects.each do |genre|
        expect(movie.genres).to include(genre)
        expect(genre.movies).to include(movie)
      end
    end
  end
end