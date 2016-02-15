class Movie

  extend ClassModule

  attr_reader :title, :actors, :director, :genres, :length, :rating

  @@all = []

  def self.all
    @@all
  end

# returns a movie object
  def self.find_by_title(title)
    self.all.detect { |movie| movie.title == title }
  end

# Movie.find_by("actors", "Emile Hirsch")
# returns an array
  def self.search_by(aspect, name)
    self.all.select { |movie| movie.send(aspect).include?(name) }
  end

# Movie.cross_reference("actors", "Bill Murray", "director", "Wes Anderson")
# returns an array
  def self.cross_reference(aspect1, name1, aspect2, name2)
    self.search_by(aspect1, name1) & self.search_by(aspect2, name2)
  end

  def self.find_incomplete
    self.all.select do |movie|
      movie.director == "Unknown" || movie.actors == [] || movie.genres == []
    end
  end

  def self.delete(title)
    doomed_film = Movie.find_by_title(title)
    Director.find_and_delete(doomed_film.director, title)
    doomed_film.actors.each { |name| Actor.find_and_delete(name, title) }
    doomed_film.genres.each { |name| Genre.find_and_delete(name, title) }
    self.all.delete(doomed_film)
    "#{title} has been deleted from your movie collection"
  end

  def initialize(title)

    m = Omdb::Api.new.fetch(title)

    @title = m[:movie].title
    @director = m[:movie].director
    @actors = m[:movie].actors.split(", ")
    @genres = m[:movie].genre.split(", ")
    @rating = m[:movie].metascore.to_i
    @length = m[:movie].runtime
    @year = m[:movie].year

    @personal_rating = 0
    @personal_notes = ""

    @@all << self
    self.add_genres(genres)
    self.add_actors(actors)
    self.add_director(@director)
  end

  def add_director(name)
    director = Director.find_by_name(name) || Director.new(name)
    director.movies << self.title
  end

  def add_genres(*genres)
    genres.flatten.each do |genre|
      genre.capitalize!
      self.genres << genre if !self.genres.include?(genre)
      genre = Genre.find_by_name(genre) || Genre.new(genre)
      genre.movies << self.title if !genre.movies.include?(self.title)
    end
  end

  def add_actors(*actors)
    actors.flatten.each do |actor|
      self.actors << actor if !self.actors.include?(actor)
      actor = Actor.find_by_name(actor) || Actor.new(actor)
      actor.movies << self.title if !actor.movies.include?(self.title)
    end
  end

end
