require_relative "../concerns/resources"

class Movie
  attr_accessor :title
  attr_reader :showtimes
  
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
     @showtimes = []
  end
  
  def add_showtime(showtime)
    @showtimes << showtime if @showtimes.none? { |time| time = showtime }
    showtime.movie = self if showtime.movie != self
    self
  end
  
  def showtimes
    @showtimes.clone.freeze
  end
  
end