require_relative "../concerns/resources"

class Showtime
  attr_accessor :time, :theatre, :details, :discount, :ticket_url
  attr_reader :movie
  
  @@all = []
  
  def self.all
    @@all
  end
  
  extend Concerns::Findable
  extend Concerns::Destroyable
  include Concerns::Savable
    
  def initialize(movie, time, theatre)
    @time = time
    self.movie = movie
    self.theatre = theatre
    movie.add_theatre(theatre)
  end
  
  def self.create(movie, time, theatre)
    self.new(movie, time, theatre).save
  end
  
  def movie=(movie)
    @movie = movie
    movie.add_showtime(self)
    self
  end
  
  def theatre=(theatre)
    @theatre = theatre
    # theatre.add_showtime(self) if 
    self
  end
end