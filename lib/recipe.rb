require "httparty"
require_relative "recipe/plain_text_presenter"
require_relative "recipe/html_presenter"
require_relative "recipe/importer"

module Recipe
  DATA_FILE = "data/recipe_data.json"

  # Outputs a random recipes
  def self.sample
    # importer = Importer.new
    # importer.import

    # local_recipe_json = File.read(importer.data_file_location)

    # all_recipes = JSON.parse(local_recipe_json)
    # recipe = all_recipes.sample

    # Presenter.new(recipe: recipe).present
  end

  # Eg: recipe --latest
  def self.latest


    puts PlainTextPresenter.new(recipe: recipe).output
  end
end
