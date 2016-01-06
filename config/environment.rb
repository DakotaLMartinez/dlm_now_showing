require 'bundler'

Bundler.require

require 'dotenv'
Dotenv.load

module Concerns
end

require_all 'lib'
