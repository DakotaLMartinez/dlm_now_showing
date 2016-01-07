require 'pry'
require "spec_helper"

describe "DlmNowShowing" do 
  let!(:new_request_url) { DlmNowShowing::RequestUrl.new(90066).url }
  let!(:today) { Time.now.strftime("%Y-%m-%d") }
  context "RequestUrl" do 
    describe "#initialize" do 
      it "accepts a zip code and returns a url containing json movie data" do 
        expect(new_request_url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{today}&zip=90066&api_key=#{ENV['API_KEY']}")
      end
      
      it "accepts optional arguments for start date and radius" do 
        expect(DlmNowShowing::RequestUrl.new(90066,today,10).url).to eq("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{today}&zip=78701&radius=10&api_key=#{ENV['API_KEY']}")
      end
    end
  end
  
  context "MovieImporter" do 
    let!(:movie_importer) { DlmNowShowing::MovieImporter.new("http://dakotaleemartinez.com/movie-data-for-test.json") }
    let!(:response) { movie_importer.response }
     describe "#initialize" do 
      it "accepts a url to parse movie information in JSON format" do 
        expect(response).to be_a(Array)
        expect(response.first["title"]).to be_a(String)
      end
      
      describe "#import" do 
        it "creates a new movie for each of the objects in the JSON response" do
          movie_importer.import
          
          expect(response.size).to eq(Movie.all.size)
        end
        
        it "creates a new showtime object for each showtime listed in the response data" do 
          movie_importer.import
          
          response.each do |movie|
            this_movie = Movie.find_by_title(movie["title"])
            expect(this_movie).not_to be_nil
            expect(this_movie).to be_a(Movie)
            movie["showtimes"].each do |showtime|
              time = showtime["dateTime"]
              theatre_id = showtime["theatre"]["id"]
              theatre = Theatre.find_by_id(theatre_id)
              showtime_object = Showtime.find_by_movie_theatre_and_time(this_movie,time,theatre)
              expect(this_movie.showtimes).to include(showtime_object)
            end
            expect(movie["showtimes"].size).to eq(this_movie.showtimes.size)
          end
        end
        
        it "assigns genres to each new movie object and does not create duplicate genres" do 
          movie_importer.import
          
          response.each do |movie|
            this_movie = Movie.find_by_title(movie["title"])
            expect(this_movie).not_to be_nil
            expect(this_movie).to be_a(Movie)
            movie["genres"].each do |genre|
              genre_object = Genre.find_by_name(genre)
              expect(genre_object).to be_a(Genre)
              expect(this_movie.genres).to include(genre_object)
            end
            expect(movie["genres"].size).to eq(this_movie.genres.size)
          end
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
          
        end
        
      end
    end
  end
end

