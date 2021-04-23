class RecipeImporter
  RECIPES_ENDPOINT = "http://api.grubdaily.com/recipes"
  JSON_DATA_FILE = "data/recipe_data.json"

  def self.import
    new.get_recipe_data
  end

  def initialize(api_recipes_endpoint: RECIPES_ENDPOINT)
    @api_recipes_endpoint = api_recipes_endpoint
  end

  def get_recipe_data
    if data_file_missing_or_needs_refreshed?
      puts "Downloading recipe data..."
      download_recipe_data
    else
      puts "Accessing recipe data locally..."
      JSON.parse(File.read(JSON_DATA_FILE))
    end
  end

  private

  attr_reader :api_recipes_endpoint

  def download_recipe_data
    response = HTTParty.get(api_recipes_endpoint).body

    File.open(JSON_DATA_FILE, "w+") do |file|
      file.write(response)
    end
  end

  def data_file_missing_or_needs_refreshed?
    return true if !data_file_exists?
    creation_of_data_file = File.ctime(JSON_DATA_FILE).to_datetime
    one_hour_ago = Time.now.to_datetime - 1

    creation_of_data_file < one_hour_ago
  end

  def data_file_exists?
    File.file?(JSON_DATA_FILE)
  end
end
