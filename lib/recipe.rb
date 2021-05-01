# frozen_string_literal: true

require "recipe/plain_text_presenter"
require "recipe/html_presenter"
require "recipe/importer"
require "recipe/recipe_api"
require "pry-byebug"

module Recipe
  DATA_FILE = "data/recipe_data.json"

  def self.sample
    client = RecipeApi.new
    importer = Importer.new(client, "data/recipe_data.json")
    importer.import

    local_recipe_json = File.read(importer.data_file_location)

    all_recipes = JSON.parse(local_recipe_json)
    recipe = all_recipes.sample

    puts PlainTextPresenter.new(recipe: recipe).output
  end
end
