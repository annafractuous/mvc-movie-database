class Director

  extend ClassModule

  attr_accessor :movies
  attr_reader :name

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @movies = []
    @@all << self
  end

end
