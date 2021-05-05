require "httparty"
require_relative "local_data_source"
require_relative "recipe"

class ApiClientWithLocalSyncing
  attr_reader :local_data_source

  GRUBDAILY_API_ROOT = "http://api.grubdaily.com/"

  def initialize(local_data_source)
    @local_data_source = local_data_source
  end

  def all_recipes
    recipes_data = JSON.parse(HTTParty.get(recipes_endpoint).body)
    persist_to_local_source(recipes_data)

    recipes_data.map{ |recipe_data| Recipe.new(recipe_data) }
  end

  private

  def recipes_endpoint
    "#{GRUBDAILY_API_ROOT}/recipes"
  end

  def persist_to_local_source(recipes_data)
    local_data_source.persist_all(recipes_data)
  end
end
