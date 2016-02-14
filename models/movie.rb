class Movie

  extend ClassModule

  attr_reader :title, :actors, :director, :genres

  @@all = []

  def self.all
    @@all
  end

# Movie.find_by("actors", "Emile Hirsch")
# returns an array
  def self.search_by(aspect, name)
    self.all.select { |movie| movie.send(aspect).include?(name) }
  end

# returns a movie object
  def self.find_by_title(title)
    self.all.detect { |movie| movie.title == title }
  end

  def self.find_incomplete
    self.all.select do |movie|
      movie.director == "Unknown" || movie.actors == [] || movie.genres == []
    end
  end

  def self.delete(title)
    doomed_film = Movie.select_by_title(title)
    Director.find_and_delete(doomed_film.director, title)
    doomed_film.actors.each { |name| Actor.find_and_delete(name, title) }
    doomed_film.genres.each { |name| Genre.find_and_delete(name, title) }
    self.all.delete(doomed_film)
    "#{title} has been deleted from your movie collection"
  end

  def initialize(title)
    @title = title
    @director = "Unknown"
    @actors = []
    @genres = []
    @@all << self
  end

  def director=(name)
    @director = name
    director = Director.find_by_name(name) || Director.new(name)
    director.movies << self.title
  end

  def add_genres(*genres)
    genres.each do |genre|
      self.genres << genre
      genre = Genre.find_by_name(genre) || Genre.new(genre)
      genre.movies << self.title
    end
  end

  def add_actors(*actors)
    actors.each do |actor|
      self.actors << actor
      actor = Actor.find_by_name(actor) || Actor.new(actor)
      actor.movies << self.title
    end
  end

end
