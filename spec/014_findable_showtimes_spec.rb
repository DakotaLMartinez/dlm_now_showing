require "spec_helper"

context "Findable Showtimes" do 
  let!(:star_wars) { Movie.create("Star Wars") }
  let!(:sisters) { Movie.create("Sisters") }
  let!(:theatre) { Theatre.create(5151, "Cinemark 18 & XD") } 
  let!(:showtime1) { Showtime.create(star_wars, "2015-12-28T18:30", theatre) }
  let!(:showtime2) { Showtime.create(star_wars, "2015-12-28T21:00", theatre) }
  let!(:showtime3) { Showtime.create(sisters, "2015-12-28T18:00", theatre) }
  describe ".find_by_movie" do 
    it "finds showtime instances that match a movie name" do 
      expect(Showtime.find_by_movie(star_wars)).to include(showtime1, showtime2)
    end
  end
  
  describe ".find_by_theatre" do 
    it "finds showtime instances playing at a theatre (by name)" do 
      expect(Showtime.find_by_theatre(theatre)).to include(showtime1, showtime2, showtime3)
    end
  end
  
  describe ".find_by_movie_and_theatre" do 
    it "finds showtimes by movie and theatre" do 
      expect(Showtime.find_by_movie_and_theatre(star_wars, theatre)).to include(showtime1, showtime2)
    end
  end
  
  describe ".find_by_movie_theatre_and_time" do 
    it "finds showtimes by movie, theatre and time" do
      expect(Showtime.find_by_movie_theatre_and_time(star_wars, "2015-12-28T18:30", theatre)).to eq(showtime1)
    end
  end
  
  describe "find_or_create_by_movie_theatre_and_time" do
    it "finds or creates a showtime maintaining the uniqueness of showtimes by movie, theatre" do 
      expect(Showtime.find_or_create_by_movie_theatre_and_time(star_wars, "2015-12-28T18:30", theatre)).to eq(showtime1)
      showtime4 = Showtime.find_or_create_by_movie_theatre_and_time(star_wars, "2015-12-28T12:00", theatre)
      expect(Showtime.find_by_movie_and_theatre(star_wars, theatre)).to include(showtime4)
    end
  end
  
end