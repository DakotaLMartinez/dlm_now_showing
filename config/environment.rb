require 'bundler'
require 'dotenv'
require 'httparty'

Bundler.require
Dotenv.load

module Concerns
end

require_all 'lib'
