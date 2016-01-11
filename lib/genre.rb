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
    @movies = []
    @theatres = []
    @showtimes = []
  end
  
  def movies
    @movies.clone.freeze
  end
  
  def add_movie(movie)
    @movies << movie if @movies.none? { |m| m == movie }
    self
  end
  
  def theatres
    self.movies.each do |movie|
      movie.showtimes.each do |showtime|
        @theatres << showtime.theatre if @theatres.none? { |t| t == showtime.theatre }
      end
    end
    @theatres.clone.freeze
  end
  
  def showtimes
    self.movies.each do |movie|
      movie.showtimes.each do |showtime|
        @showtimes << showtime if @showtimes.none? { |t| t == showtime }
      end
    end
    @showtimes.clone.freeze
  end
  
  def self.find_by_name(name)
    self.all.detect { |g| g.name.downcase.match(name.downcase) }
  end
    
end