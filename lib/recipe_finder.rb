require "httparty"
require_relative "recipe_presenter"
require_relative "recipe_importer"

class RecipeSampler
  class Error < StandardError; end

  DATA_FILE = "data/recipe_data.json"

  def self.sample_recipe
    RecipeImporter.import

    local_recipe_json = File.read(RecipeImporter::JSON_DATA_FILE)

    all_recipes = JSON.parse(local_recipe_json)
    recipe = all_recipes.sample

    RecipePresenter.new(recipe: recipe).present
  end
end
