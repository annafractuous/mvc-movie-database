require 'pry'
require_relative '../config/environment.rb'
require_relative 'seed.rb'

def reload!
  load('../config/environment.rb')
end

def movie_help
  puts "To see a list of all your movies, actors, directors or genres:"
  puts "   — Movie.all, Actor.all, Director.all or Genre.all"
  puts "To add a movie:"
  puts "   — Movie.new(\"Rushmore\")"
  puts "To find a movie by title:"
  puts "   – Movie.find_by_title(\"Pulp Fiction\")"
  puts "To search movies by genres, actors or director:"
  puts "   – Movie.search_by(\"director\",\"Wes Anderson\")"
  puts "   – Movie.search_by(\"actors\",\"Bill Murray\")"
  puts "   – Movie.search_by(\"genres\",\"comedy\")"
  puts "To find movies with incomplete information:"
  puts "   – Movie.find_incomplete"
  puts "To delete a movie:"
  puts "   – Movie.delete(\"Monster-in-Law\")"
  "Let's work on your movie database!"
end

# Executable code here
puts "Welcome to your personal movie database!"
puts "Type a command, or type \"movie_help\" to see a list of what you can do."


Pry.start
