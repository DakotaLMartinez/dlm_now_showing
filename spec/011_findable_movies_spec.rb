require "spec_helper"

context "Findable Movies" do 
  let!(:star_wars) { Movie.create("Star Wars") }
  describe ".find_by_name" do
    it "finds a movie instance in @@all by the title property of the movie" do 
      expect(Movie.find_by_name("Star Wars")).to eq(star_wars)
    end
  end
  
  describe ".find_or_create_by_name" do 
    it "finds or creates a movie by name(title), maintaining uniqueness of movies by their name(title) property" do 
      star_wars2 = Movie.find_or_create_by_name("Star Wars")
      expect(star_wars2).to eq(star_wars)
    end
  end
end