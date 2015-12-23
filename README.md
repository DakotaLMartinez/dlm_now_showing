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

Add this line to your application's Gemfile:

```ruby
gem 'dlm_now_showing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dlm_now_showing

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dlm_now_showing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
