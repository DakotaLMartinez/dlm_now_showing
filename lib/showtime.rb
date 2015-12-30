require_relative "../concerns/resources"

class Showtime
  attr_accessor :time, :theatre, :movie, :details, :discount, :ticket_url
  
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable
    
  def initialize(time)
    @time = time
  end
end