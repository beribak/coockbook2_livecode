require_relative "view"
require_relative "recipe"
require_relative "scraper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # USER ACTIONS

  def list
    display_recipes
  end

  def import
    # 1. Ask user for dish for recipes
    dish = @view.ask_user_dish_name
    # 2. Get recipes from allrecipes website
    results = ScraperRecipes.new(dish).call
    # 3. Display recipes choices
    @view.display(results)
    # 4. Ask user for desired recipe
    index = @view.ask_user_for_index
    # 5. Store recipe in cookbook
    @cookbook.add_recipe(results[index])
  end

  def create
    # 1. Ask user for a name (view)
    name = @view.ask_user_for("name")
    # 2. Ask user for a description (view)
    description = @view.ask_user_for("description")
    # 3. Create recipe (model)
    recipe = Recipe.new(name, description)
    # 4. Store in cookbook (repo)
    @cookbook.add_recipe(recipe)
    # 5. Display
    display_recipes
  end

  def destroy
    # 1. Display recipes
    display_recipes
    # 2. Ask user for index (view)
    index = @view.ask_user_for_index
    # 3. Remove from cookbook (repo)
    @cookbook.remove_recipe(index)
    # 4. Display
    display_recipes
  end

  private

  def display_recipes
    # 1. Get recipes (repo)
    recipes = @cookbook.all
    # 2. Display recipes in the terminal (view)
    @view.display(recipes)
  end
end
