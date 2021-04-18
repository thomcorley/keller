require "httparty"
require_relative "recipe_presenter"

class RecipeFinder
  class Error < StandardError; end

  RECIPES_URL = "http://api.grubdaily.com/recipes"
  DATA_FILE = "data/recipe_data.json"

  def self.sample
    get_recipe_data

    all_recipes = JSON.parse(File.read(DATA_FILE))
    recipe = all_recipes.sample

    RecipePresenter.new(recipe: recipe).present
  end

  def self.get_recipe_data
    if !data_file_exists?
      download_recipe_data
    elsif data_needs_refreshed?
      download_recipe_data
    else
      puts "Accessing recipe data locally"
      JSON.parse(File.read(DATA_FILE))
    end
  end

  def self.download_recipe_data
    puts "Downloading recipe data..."
    response = HTTParty.get(RECIPES_URL).body

    File.open(DATA_FILE, "w+") do |file|
      file.write(response)
    end
  end

  def self.data_file_exists?
    File.file?(DATA_FILE)
  end

  def self.data_needs_refreshed?
    creation_of_data_file = File.ctime(DATA_FILE).to_datetime
    one_hour_ago = Time.now.to_datetime - 1

    creation_of_data_file < one_hour_ago
  end
end
