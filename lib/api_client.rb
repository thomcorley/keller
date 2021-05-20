require "httparty"
require_relative "recipe"

class ApiClient
  GRUBDAILY_API_ROOT = "http://api.grubdaily.com/"
  RECIPES_ENDPOINT = "#{GRUBDAILY_API_ROOT}/recipes"

  def all_recipes
    recipes_hash = JSON.parse(recipes_response)
    recipes_hash.map{ |recipe_data| Recipe.new(recipe_data) }
  end

  private

  def recipes_response
    HTTParty.get(RECIPES_ENDPOINT).body
  end
end
