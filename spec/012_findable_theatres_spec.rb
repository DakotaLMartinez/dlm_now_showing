require "spec_helper"

context "Findable Theatres" do 
  let!(:theatre1) { Theatre.create(5151).name = "Cinemark 18 & XD" }
  let!(:theatre2) { Theatre.create(5152).name = "Cinemark 18 & XD" }
  describe ".find_by_name" do 
    it "finds a theatre instance in @@all by the name property of the theatre" do 
      expect(Theatre.find_by_name("Cinemark 18 & XD")).to include(theatre1, theatre2)
    end
  end
  
  describe ".find_by_id" do 
    it "finds a theatre in @@all by the id property of the theatre" do 
      expect(Theatre.find_by_id(5151)).to eq(theatre1)
    end
  end
  
  describe ".find_or_create_by_id_and_name" do 
    it "finds or creates a theatre by id and name properties maintaining uniqueness of theatres by their id property" do 
      theatre3 = Theatre.find_or_create_by_id_and_name(5152, "Cinemark 18 & XD!!!")
      theatre4 = Theatre.find_or_create_by_id_and_name(5153, "Cinemark 18 & XD")
      expect(theatre3).to eq(theatre2)
      expect(theatre4.name).to eq(theatre1.name)
    end
  end
end