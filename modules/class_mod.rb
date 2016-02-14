module ClassModule

# return an actor, director or genre by its name
  def find_by_name(name)
    self.all.detect { |instance| instance.name == name }
  end

  def exists?(name)
    find_by_name(name) ? true : false
  end

  def find_and_delete(name, movie)
    instance = self.all.find { |instance| instance.name == name }
    instance.movies.size > 1 ? instance.movies.delete(movie) : self.all.delete(instance)
  end

end
