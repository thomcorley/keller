require "httparty"
require_relative "recipe"

class ApiClient
  GRUBDAILY_API_ROOT = "http://api.grubdaily.com/"

  def all_recipes_hash
    @all_recipes_hash ||= JSON.parse(HTTParty.get(recipes_endpoint).body)
  end

  def all_recipes
    all_recipes_hash.map{ |recipe_data| Recipe.new(recipe_data) }
  end

  private

  def recipes_endpoint
    "#{GRUBDAILY_API_ROOT}/recipes"
  end
end
