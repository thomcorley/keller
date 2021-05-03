# frozen_string_literal: true

require "pry-byebug"
require "active_support/all"
require "recipe/plain_text_presenter"
require "recipe/html_presenter"
require "recipe/recipe_api"
require "recipe/local_recipes"
require "recipe/recipe_repository"

module Recipe
  class Cli
    DATA_FILE = "data/recipe_data.json"

    def sample
      recipe = recipe_repository.all.sample
      puts presenter.output(recipe)
    end

    private

    def recipe_repository
      RecipeRepository.new(LocalRecipes.new(DATA_FILE), RecipeApi.new)
    end

    def presenter
      # could check CLI arguments here to switch between plain-text/html
      PlainTextPresenter.new
    end
  end
end
