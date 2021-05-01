# frozen_string_literal: true

require "httparty"
require "recipe/recipe_rep"

module Recipe
  class RecipeApi
    GRUBDAILY_API_ROOT = "http://api.grubdaily.com"

    def all
      req("recipes").map { |recipe| Recipe::RecipeRep.new(recipe) }
    end

    private

    attr_reader :recipes_endpoint

    def req(endpoint)
      JSON.parse(HTTParty.get("#{GRUBDAILY_API_ROOT}/#{endpoint}").body)
    end
  end
end

