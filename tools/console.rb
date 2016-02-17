require 'pry'
require 'omdb'
require_relative '../config/environment.rb'
require_relative 'seed.rb'

# THOUGHTS
# update movie_help list of commands
# add CLI interface

def reload!
  load('../config/environment.rb')
end

Pry.start
