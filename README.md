# DlmNowShowing

The dlm_now_showing gem installs a command line interface that allows users to list movies now playing at theatres within a certain radius of a given zip code (default radius is 5 miles).

### The CLI supports the following commands:
* list movies (lists movies currently playing within the currently specified radius)
* list movie (lists nearby movie showtimes of a particular movie)
* list theatres (lists theatres within the currently specified radius)
* list theatre (lists movies showtimes at a specified theatre)
* list genres (lists movie genres of movies playing nearby)
* list genre (lists movies of a specified genre that are showing nearby)
* change radius (changes the radius around the given zipcode that the program will look for movie showtimes)
* change date (changes the date of the showtimes listed)
* help (displays a list of available commands)


## Installation

First, you'll want to clone the repository

```ruby
git clone git@github.com:DakotaLMartinez/dlm_now_showing.git
```

And then execute:

    $ bundle

## Usage

To use this gem, you'll need to create an account with the [Gracenote OnConnect API service](http://developer.tmsapi.com/member/register) in order to access movie showtimes. After creating your account and receiving your API key, you'll want to add it to a `.env` file at the root of this project:

```
API_KEY=your_api_key_goes_here
```

After you've gotten your API key, you can run the CLI and navigate through movie showtimes in your area by running the following command:

```
ruby bin/nowshowing
```

Upon booting the CLI, you'll be presented with a list of options for navigating through showtimes. The main 3 approaches are to navigate via a list of Movies, Theatres or Genres. If you'd like to play around with the CLI before signing up for an API key, you can run it against some static data with the following command:

```
ruby bin/nowshowingtest
```

### Navigating by Movies

If you type `movies` into the CLI, you'll see a list of all the movies with upcoming showtimes within the radius you specified from the desired ZIP code. 

The movies are numbered, and choosing the number next to a movie will show you all the nearby theatres that have upcoming showtimes of that movie. 

Once you select a number, you can still select another number from the list to view showtimes of other movies on the list.

### Navigating by Theatres 

If you type `theatres` into the CLI, you'll see a numbered list of all of the theatres in your specified area with upcoming showtimes. Selecting a theatre by its number will show a numbered list of all of the movies playing at that theatre. 

If you see a movie in the list that you want to see, but there aren't any good showtimes, you can select that movie by its number and you'll see all the other theatres nearby that are showing that movie. 

You'll still be able to select any of the movies from the numbered list of movies playing at the first theatre you chose. Enter the number corresponding to that movie and you'll see a list of showtimes of the selected movie at other theatres.

### Navigating by Genres

If you type `genres` into the CLI, you'll see a numbered list of all of the genres of movies that have upcoming showtimes in the specified area. Selecting a genre by its number will show a numbered list of all the movies of that genre with upcoming showtimes. 

Selecting a movie from that list will show you a list of the showtimes of that movie by theatre. You'll still be able to select any of the other movies of the selected genre to view their nearby showtimes.


If you'd like to play around with the CLI without getting your own API key, interface

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dlm_now_showing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
