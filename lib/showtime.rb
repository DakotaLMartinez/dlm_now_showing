require_relative "../concerns/resources"

class Showtime
  attr_accessor :time, :theatre, :details, :discount, :ticket_url
  attr_reader :movie
  
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable
    
  def initialize(time, movie=nil)
    @time = time
    self.movie = movie if movie
  end
  
  def movie=(movie)
    @movie = movie
    movie.add_showtime(self)
    self
  end
end