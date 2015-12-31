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
  
  def initialize(title,genres=nil)
     @title = title 
     @showtimes = []
     if genres
       @genres = []
       genres.each do |genre|
         add_genre(Genre.find_or_create_by_name(genre))
       end
     else
       @genres = []
     end
  end
  
  def add_showtime(showtime)
    @showtimes << showtime if @showtimes.none? { |time| time = showtime }
    showtime.movie = self if showtime.movie != self
    self
  end
  
  def showtimes
    @showtimes.clone.freeze
  end
  
  def genres
    @genres.clone.freeze
  end
  
  def add_genre(genre)
    @genres << genre if @genres.none? { |g| g == genre }
    genre.add_movie(self) if genre.movies.none? { |m| m == self }
    self
  end
  
end