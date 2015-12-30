require_relative "../concerns/resources"

class Genre
  attr_accessor :name
    
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable  
  
  def initialize(name)
    @name = name
  end
    
end