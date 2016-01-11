require_relative "../concerns/resources"
require 'pry'

class MovieShowingsController
  attr_reader :searches, :zip_code
  def initialize
    @searches = []
  end
  
  # functions to get proper search query from gracenote api
  
  def get_zip_code
    puts "Please enter the zip code you'd like to search for movie showtimes."
    zip_code = gets.to_s.chomp
    if zip_code.length == 5 && zip_code.match(/\d{5}/)
      return zip_code
    elsif zip_code == "exit"
      "exit"
    else
      puts "Whoops!  Make sure you enter a 5 digit zip code"
      get_zip_code
    end
  end
  
  def get_search_radius
    puts "The default search radius for movie showtimes is 5 miles. Press Enter if this is okay, or enter a number between 1 and 100 if you'd like to change the search radius."
    search_radius = gets.to_s.chomp
    if search_radius == ""
      "5"
    elsif search_radius.to_i.between?(1,100)
      search_radius
    elsif search_radius == "exit"
      "exit"
    else
      puts "Whoops! I didn't understand your response."
      get_search_radius
    end
  end
  
  def get_showing_date
    puts "The default showing date is today.  Press enter is this is okay, or enter a future date in the following format #{(Time.now+172800).strftime("%Y-%m-%d")}."
    showing_date = gets.to_s.chomp
    if showing_date == ""
      Time.now.strftime("%Y-%m-%d")
    elsif showing_date.length == 10 && showing_date.match(/\d{4}-\d{2}-\d{2}/)
      showing_date
    elsif showing_date == "exit"
      "exit"
    else
      puts "Whoops! I didn't understand your response."
      get_showing_date
    end
  end
  
  # helper methods for movies, movie commands
  
  def list_movies(movies)
    movies.each_with_index do |movie, index|
      puts "#{index+1}. #{movie.title}"
    end
  end
  
  def convert_to_am_pm(time_string)
    t = time_string.split("T")[1]
    time = t.split(":")
    if time[0].to_i > 12
      time[0] = (time[0].to_i - 12).to_s
      time.insert(1,":")
    elsif time[0].to_i == 12
      time.insert(1,":")
      time << "PM"
    else
      time.insert(1,":")
      time << "AM"
    end
    time.join("")
  end
  
  def display_all_showtimes(movie)
    puts "#{movie.title} is playing at:"
    movie.theatres.each do |theatre|
      puts "  #{theatre.name}"
      Showtime.find_by_movie_and_theatre(movie, theatre).each do |showtime|
        print "    #{convert_to_am_pm(showtime.time)}"
      end
      puts ""
    end
  end
  
  def list_showtimes_by_movie(movies)
    print "Choose a movie (by number) to list nearby showtimes: "
    input = gets.chomp
    if input.to_i.between?(1,movies.size)
      movie = movies[input.to_i-1]
      display_all_showtimes(movie)
    elsif input.downcase == "exit"
      "exit"
    elsif input.downcase == "home"
      ask_for_command
    else
      puts "Whoops!  I didn't see a movie matching that number."
      list_showtimes_by_movie(movies)
    end
  end
  
  def find_movie
    print "Which movie would you like to see?  Enter the title here: "
    input = gets.chomp
    if Movie.search_by_title(input) != []
      movies = Movie.search_by_title(input)
      list_movies(movies)
      list_showtimes_by_movie(movies)
    elsif input == "home"
      ask_for_command
    elsif input == "exit"
      "exit"
    else
      puts "Whoops! I didn't find a movie by that title."
      puts "'home' will return to main prompt, 'exit' will quit the program"
      find_movie
    end
  end
  
  # helper methods for genres, genre commands
  
  def list_genres(genres)
    genres.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end
  
  def list_showtimes_by_genre
    print "Choose a genre (by number) to list movies playing nearby: "
    input = gets.chomp
    if input.to_i.between?(1,Genre.all.size)
      genre = Genre.all[input.to_i-1]
      movies = genre.movies
      puts "The following movies of the #{genre.name} genre are playing nearby:"
      movies.each_with_index do |movie, index|
        puts "#{index+1}. #{movie.title}"
      end
      return "exit" if list_showtimes_by_movie(movies) == "exit"
    elsif input.downcase == "exit"
      "exit"
    elsif input.downcase == "home"
      ask_for_command
    else
      puts "Whoops!  I didn't see a genre matching that number."
      list_showtimes_by_genre
    end
  end
  
  def find_genre
    puts "Which genre of movie would you like to watch?"
    input = gets.chomp
    if Genre.find_by_name(input)
      movies = Genre.find_by_name(input).movies
      list_movies(movies)
      list_showtimes_by_movie(movies)
    elsif input.downcase == "exit"
      "exit"
    elsif input.downcase == "home"
      ask_for_command
    else
      puts "Whoops!  I didn't find a genre matching #{input}"
      find_genre
    end
  end
  
  # helper methods for theatres, theatre commands
  
  def list_theatres(theatres)
    theatres.each_with_index do |theatre, index|
      puts "#{index+1}. #{theatre.name}"
    end
  end
  
  def list_showtimes_by_theatre(theatres)
    print "Choose a theatre (by number) to list its movies and showtimes: "
    input = gets.chomp
    if input.to_i.between?(1,theatres.size)
      theatre = theatres[input.to_i-1]
      display_all_showtimes_at(theatre)
      puts "If you see a movie you like here but can't make it:"
      list_showtimes_by_movie(theatre.movies)
    elsif input.downcase == "exit"
      "exit"
    elsif input.downcase == "home"
      ask_for_command
    else
      puts "Whoops!  I didn't see a theatre matching that number."
      puts "'home' will return to main prompt, 'exit' will quit the program"
      list_showtimes_by_theatre(theatres)
    end
  end
  
  def display_all_showtimes_at(theatre)
    puts "The following movies are playing at #{theatre.name}"
    theatre.movies.each_with_index do |movie, index|
      puts "#{index+1}. #{movie.title}"
      Showtime.find_by_movie_and_theatre(movie, theatre).each do |showtime|
        print "  #{convert_to_am_pm(showtime.time)}"
      end
      puts ""
    end
  end
  
  def find_theatre
    print "Which theatre would you like to display showtimes for?: "
    input = gets.chomp
    if Theatre.find_by_name(input) != []
      theatres = Theatre.find_by_name(input)
      list_theatres(theatres)
      list_showtimes_by_theatre(theatres)
    elsif input.downcase == "exit"  
      "exit"
    elsif input.downcase == "home"
      ask_for_command
    else
      puts "Whoops!  I didn't find any theatres matching that name."
      puts "'home' will return to main prompt, 'exit' will quit the program"
      find_theatre
    end
  end
  
  def list_commands
    puts "The following commands are available:"
    puts "  movies \tlists movies with nearby showtimes"
    puts "  movie \tlists the nearby showtimes of a particular movie"
    puts "  genres \tlists the genres of movies playing nearby"
    puts "  genre \tlists the nearby showtimes of a particular genre"
    puts "  theatres \tlists the theatres with showtimes nearby"
    puts "  theatre \tlists the showtimes of movies at a particular theatre"
    puts "  home \t\treturns to the home prompt where all commands are available"
    puts "  exit \t\tquits the program"
  end
  
  def ask_for_command
    puts "What would you like to do? (type 'help' for a list of commands or 'exit' to quit)"
    command = gets.chomp
    if command.downcase == "exit"
      "exit"
    elsif command.downcase == "help"
      list_commands
      ask_for_command
    elsif command.downcase == "home"
      puts "You're already home :-)"
      ask_for_command
    elsif command.downcase == "movies"
      list_movies(Movie.all)
      return "exit" if list_showtimes_by_movie(Movie.all) == "exit"
      ask_for_command
    elsif command.downcase == "movie"
      return "exit" if find_movie == "exit"
      ask_for_command
    elsif command.downcase == "genres"
      list_genres(Genre.all)
      return "exit" if list_showtimes_by_genre == "exit"
      ask_for_command
    elsif command.downcase == "genre"
      return "exit" if find_genre == "exit"
      ask_for_command
    elsif command.downcase == "theatres"
      list_theatres(Theatre.all)
      return "exit" if list_showtimes_by_theatre(Theatre.all) == "exit"
      ask_for_command
    elsif command.downcase == "theatre"
      return "exit" if find_theatre == "exit"
      ask_for_command
    else
      puts "Whoops! I didn't recognize that command."
      ask_for_command
    end
  end
  
  def call(request_url="")
    if request_url == ""
      zip_code = get_zip_code
      return if zip_code == "exit"
      search_radius = get_search_radius
      return if search_radius == "exit"
      showing_date = get_showing_date
      return if showing_date == "exit"
      request_url = DlmNowShowing::RequestUrl.new(zip_code, search_radius, showing_date).url
    end
    puts "We're getting the movie data now."
    
    movie_importer = DlmNowShowing::MovieImporter.new(request_url)
    movie_importer.import
    
    puts "All right!  Welcome to the DlmNowShowing Movie Showings Command Line Interface!"
    list_commands
    return if ask_for_command == "exit"
  end
end