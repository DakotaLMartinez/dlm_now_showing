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
  
  def genres
    self.movie.genres
  end
  
  def self.find_by_title(title)
    self.all.select { |showtime| showtime.movie.title == title }
  end
  
  def self.find_by_movie(movie)
    self.all.select { |showtime| showtime.movie == movie }
  end
  
  def self.find_by_theatre_name(name)
    self.all.select { |showtime| showtime.theatre.name == name }
  end
  
  def self.find_by_theatre(theatre)
    self.all.select { |showtime| showtime.theatre == theatre }
  end
  
  def self.find_by_movie_and_theatre(movie, theatre)
    self.all.select { |showtime| showtime.movie == movie && showtime.theatre == theatre }
  end
  
  def self.find_by_movie_time_and_theatre(movie, time, theatre)
    self.all.detect { |showtime| showtime.movie == movie && showtime.theatre == theatre && showtime.time == time }
  end
  
  def self.find_or_create_by_movie_time_and_theatre(movie, time, theatre)
    if self.find_by_movie_time_and_theatre(movie, time, theatre)
      self.find_by_movie_time_and_theatre(movie, time, theatre)
    else
      self.create(movie, time, theatre)
    end
  end
  
end