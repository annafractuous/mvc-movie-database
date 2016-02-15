module ClassModule

# return an actor, director or genre by its name
  def find_by_name(name)
    self.all.detect { |instance| instance.name == name }
  end

  def find_and_delete(name, movie)
    instance = self.all.find { |instance| instance.name == name }
    instance.movies.size > 1 ? instance.movies.delete(movie) : self.all.delete(instance)
  end

  def genres(name)
    person = self.find_by_name(name)
    persons_movies = Movie.search_by("director", name) if self == Director
    persons_movies = Movie.search_by("actors", name) if self == Actor
    persons_movies.map { |movie| movie.genres }.flatten.uniq
  end

end
