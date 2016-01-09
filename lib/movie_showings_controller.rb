require_relative "../concerns/resources"

class MovieShowingsController
  attr_reader :searches, :zip_code
  def initialize
    @searches = []
  end
  
  def get_zip_code
    puts "Please enter the zip code you'd like to search for movie showtimes."
    zip_code = gets.to_s.chomp
    if zip_code.length == 5 && zip_code.match(/\d{5}/)
      return zip_code
    elsif zip_code == "exit"
      return
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
      return
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
      return
    else
      puts "Whoops! I didn't understand your response."
      get_showing_date
    end
  end
  
  def call
    zip_code = get_zip_code
    search_radius = get_search_radius
    showing_date = get_showing_date
    puts "What would you like to do? (type 'exit' to quit)"
    input = gets.chomp
    if input == "exit"
      return
    end
  end
end