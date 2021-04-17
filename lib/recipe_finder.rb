require "httparty"
require_relative "recipe_summary"

class RecipeFinder
  class Error < StandardError; end

  def self.find
    # TODO: change this to production endpoint when it's deployed
    response = HTTParty.get("http://api.lvh.me:2020/recipe")
    recipe_data = JSON.parse(response.body)

    recipe_summary = RecipeSummary.new(recipe_data: recipe_data)

    puts recipe_summary.to_json
  end
end
