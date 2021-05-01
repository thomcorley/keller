# frozen_string_literal: true

require "httparty"
require "recipe/recipe"

class RecipeApi
  GRUBDAILY_API_ROOT = "http://api.grubdaily.com"

  def recipes
    req("recipes").map { |recipe| Recipe::Recipe.new(recipe) }
  end

  private

  attr_reader :recipes_endpoint

  def req(endpoint)
    JSON.parse(HTTParty.get("#{GRUBDAILY_API_ROOT}/#{endpoint}").body)
  end
end
