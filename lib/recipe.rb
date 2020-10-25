class Recipe
  attr_reader :name, :description

  def initialize(name, description, prep_time = "", rating = "")
    @name = name
    @description = description
    @prep_time = prep_time
    @rating = rating 
end
end
