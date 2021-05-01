# frozen_string_literal: true

require "pry-byebug"
require "active_support/all"
require "recipe/plain_text_presenter"
require "recipe/html_presenter"
require "recipe/importer"
require "recipe/recipe_api"

module Recipe
  class Cli
    DATA_FILE = "data/recipe_data.json"

    def sample
      importer.import
      local_recipe_json = JSON.parse(File.read(importer.data_file_location)).sample
      recipe = Recipe.new(local_recipe_json)
      puts presenter.output(recipe)
    end

    private

    def api_client
      RecipeApi.new
    end

    def importer
      Importer.new(api_client, DATA_FILE)
    end

    def presenter
      PlainTextPresenter.new
    end
  end
end
