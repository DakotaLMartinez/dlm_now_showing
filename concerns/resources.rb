module Concerns::Creatable
   
  def create(name)
    self.new(name).save
  end
    
end

module Concerns::Destroyable
  
  def destroy_all
    self.all.clear
  end
  
end

module Concerns::Savable
  
  def save
    self.class.all << self
    self
  end
  
end

module Concerns::Findable
  
  def find_by_name(name)
    self.all.detect { |e| e.name == name }
  end
  
  def find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end
  
end