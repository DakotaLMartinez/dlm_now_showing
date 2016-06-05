require 'pry'
require "spec_helper"

describe "DlmNowShowing" do 
  let!(:new_request_url) { DlmNowShowing::RequestUrl.new(90066).url }
  let!(:today) { Time.now.strftime("%Y-%m-%d") }
  context "RequestUrl" do 
    describe "#initialize" do 
      it "accepts a zip code and returns a url containing json movie data" do 
        expect(new_request_url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{today}&zip=90066&radius=5&api_key=#{ENV['API_KEY']}")
      end
      
      it "accepts optional arguments for start date and radius" do 
        expect(DlmNowShowing::RequestUrl.new(90066,10,today).url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{today}&zip=90066&radius=10&api_key=#{ENV['API_KEY']}")
      end
    end
  end
  
  context "MovieImporter" do 
    let!(:movie_importer) { DlmNowShowing::MovieImporter.new("http://dakotaleedev.webfactional.com/test.json") }
    let!(:response) { movie_importer.response }
     describe "#initialize" do 
      it "accepts a url to parse movie information in JSON format" do 
        expect(response).to be_a(Array)
        expect(response.first["title"]).to be_a(String)
      end
      
      describe "#import" do 
        it "creates a new movie for each of the objects in the JSON response, maintaining uniqueness of movies by title" do
          movie_importer.import
          
          expect(response.size).to eq(46)
          expect(Movie.all.size).to eq(46)
          # clear_all
        end
        
        it "creates a new showtime object for each showtime listed in the response data maintaining uniquess of showtimes by movie, time and theatre" do 
          movie_importer.import
          
          showtimes_in_data = []
          showtimes_in_program = []
          response.each do |movie|
            this_movie = Movie.find_by_title(movie["title"])
            expect(this_movie).not_to be_nil
            expect(this_movie).to be_a(Movie)
            # binding.pry
            showtimes_in_data << movie["showtimes"].size
            showtimes_in_program << this_movie.showtimes.size
            # expect(movie["showtimes"].size).to eq(this_movie.showtimes.size)
          end
          # expect the program to handle duplicate movies. Indices 14 & 19 both refer to 
          # 'The Hateful Eight', so the showtimes in the data are 37 & 8 respectively, 
          # while the showtimes in the program are 45 (the sum) for each (the program 
          # recognizes that the showtimes both belong to the same movie)
          # binding.pry
          expect(showtimes_in_data).to eq([72, 26, 5, 37, 4, 13, 14, 25, 3, 8, 25, 30, 30, 49, 23, 52, 42, 29, 10, 4, 1, 1, 2, 1, 17, 6, 13, 5, 5, 5, 5, 3, 3, 3, 3, 2, 5, 6, 6, 6, 8, 5, 1, 2, 4, 1])
          expect(showtimes_in_program).to eq([72, 26, 5, 37, 4, 13, 14, 25, 3, 8, 20, 22, 30, 44, 23, 48, 37, 24, 10, 4, 1, 1, 2, 1, 17, 6, 13, 5, 5, 5, 5, 3, 3, 3, 3, 2, 5, 6, 6, 6, 8, 5, 1, 2, 4, 1])
          # clear_all
        end
        
        it "assigns genres to each new movie object and does not create duplicate genres" do 
          movie_importer.import
          
          # binding.pry
          genres_in_data = []
          genres_in_program = []
          response.each do |movie|
            this_movie = Movie.find_by_title(movie["title"])
            expect(this_movie).not_to be_nil
            expect(this_movie).to be_a(Movie)
            
            # genres << movie["genres"]
            if movie["genres"]
              genres_in_data << movie["genres"]
              genres_in_program << this_movie.genres
            else
              genres_in_data << 0
              genres_in_program << 0
            end
          end
          expect(genres_in_data.size).to eq(genres_in_program.size)
          expect(Genre.all.size).to eq(19)
          # binding.pry
        end
            
        it "assigns each theatre that is playing a movie to the movie's theatres collection" do 
          movie_importer.import
          
          response.each do |movie|
            this_movie = Movie.find_by_title(movie["title"])
            expect(this_movie).to be_a(Movie)
            expect(this_movie).not_to be_nil
            
            movie["showtimes"].each do |showtime|
              theatre_id = showtime["theatre"]["id"]
              theatre = Theatre.find_by_id(theatre_id)
              expect(theatre).to be_a(Theatre)
              expect(this_movie.theatres).to include(theatre)
            end
          end
          # clear_all
        end
        
      end
    end
  end
end

