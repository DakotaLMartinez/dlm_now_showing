require "spec_helper"

context "Findable Genres" do 
  let!(:comedy) { Genre.create("Comedy") }
  describe ".find_by_name" do 
    it "finds a genre instance in @@all by the name property of the genre" do 
      expect(Genre.find_by_name("Comedy")).to eq(comedy)
    end
  end
  
  describe ".find_or_create_by_name" do 
    it "finds or creates a genre by name, maintaining uniquess of genres by their name property" do 
      comedy2 = Genre.find_or_create_by_name("Comedy")
      expect(comedy2).to eq(comedy)
    end
  end
end