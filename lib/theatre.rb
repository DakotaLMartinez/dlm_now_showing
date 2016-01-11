require_relative "../concerns/resources"

class Theatre
  attr_accessor :name
  attr_reader :id, :showtimes
  
  @@all = []
  
  def self.all
    @@all
  end
  
  # extend Concerns::Findable
  # extend Concerns::Creatable
  extend Concerns::Destroyable
  include Concerns::Savable
  
  def initialize(id, name=nil)
    @id = id
    @showtimes = []
    @movies = []
    @genres = []
    self.name = name if name != nil
  end
  
  # def add_showtime(showtime)
  #   if Showtime.all.none? { |s| s == showtime }
  #     @showtimes << showtime if showtimes.none? { |s| s == showtime }
  #   end
  #   self
  # end
  
  def showtimes
    Showtime.all.select { |showtime| showtime.theatre == self }
  end
  
  def add_movie(movie)
    @movies << movie if @movies.none? { |m| m == movie }
    self
  end
  
  def movies
    @movies.clone.freeze
  end
  
  def genres
    self.showtimes.each do |showtime|
      showtime.movie.genres.each do |genre|
        @genres << genre if @genres.none? { |g| g == genre }
      end
    end
    @genres.clone.freeze
  end
  
  def add_genre(genre)
    @genres << genre if @genres.none? { |g| g == genre }
    self
  end
  
  def self.find_by_name(name)
    self.all.select { |t| t.name.downcase.match(name.downcase) }
  end
  
  def self.find_by_id(id)
    self.all.detect { |t| t.id == id }
  end
  
  def self.find_or_create_by_id_and_name(id, name)
    self.find_by_id(id) ? self.find_by_id(id) : self.create(id, name)
  end
  
  def self.create(id, name=nil)
    self.new(id,name).save
  end
  
end