require_relative "../concerns/resources"

class Movie
  attr_accessor :title
  
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable
  
  def initialize(title)
     @title = title 
  end
end