require_relative "../concerns/resources"

class Theatre
  attr_accessor :id, :name
  
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable
  
  def initialize(id)
    @id = id
  end
  
end