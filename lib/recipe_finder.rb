require "httparty"
require_relative "recipe_presenter"

class RecipeFinder
  class Error < StandardError; end

  def self.find
    # TODO: change this to production endpoint when it's deployed
    response = HTTParty.get("http://api.lvh.me:2020/recipe")
    recipe_data = JSON.parse(response.body)

    RecipePresenter.new(recipe_data: recipe_data).present
  end
end
