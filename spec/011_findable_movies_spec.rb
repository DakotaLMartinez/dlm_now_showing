require "spec_helper"

context "Findable Movies" do 
  let!(:star_wars) { Movie.create("Star Wars") }
  describe ".find_by_title" do
    it "finds a movie instance in @@all by the title property of the movie" do 
      expect(Movie.find_by_title("Star Wars")).to eq(star_wars)
    end
  end
  
  describe ".find_or_create_by_title" do 
    it "finds or creates a movie by title, maintaining uniqueness of movies by their title property" do 
      star_wars2 = Movie.find_or_create_by_title("Star Wars")
      expect(star_wars2).to eq(star_wars)
    end
  end
end