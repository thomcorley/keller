require "httparty"

class ApiDataSource
  attr_reader :recipes_endpoint

  GRUBDAILY_RECIPES_ENDPOINT = "http://api.grubdaily.com/recipes"

  def initialize(recipes_endpoint: GRUBDAILY_RECIPES_ENDPOINT)
    @recipes_endpoint = recipes_endpoint
  end

  def recipes
    HTTParty.get(recipes_endpoint).body
  end
end
