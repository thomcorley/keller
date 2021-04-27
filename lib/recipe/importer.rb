module Recipe
  class Importer
    JSON_RECIPES_ENDPOINT = "http://api.grubdaily.com/recipes"
    JSON_DATA_FILE = "data/recipe_data.json"

    def initialize(api_recipes_endpoint: JSON_RECIPES_ENDPOINT)
      @api_recipes_endpoint = api_recipes_endpoint
    end

    def import
      if data_file_missing_or_needs_refreshed?
        download_recipe_data
      else
        parse_local_recipe_data
      end
    end

    def data_file_location
      @data_file_location ||= find_data_file
    end

    private

    attr_reader :api_recipes_endpoint

    def download_recipe_data
      # There's a dependency on HTTParty (could maybe create a RecipeApi class
      # as wrapper)
      response = HTTParty.get(api_recipes_endpoint).body

      # There's a dependency on File
      File.open(data_file_location, "w+") do |file|
        file.write(response)
      end
    end

    def parse_local_recipe_data
      # There's a dependency on JSON
      JSON.parse(File.read(data_file_location))
    end

    def data_file_missing_or_needs_refreshed?
      return true if !data_file_exists?
      creation_of_data_file = File.ctime(data_file_location).to_datetime
      one_hour_ago = Time.now.to_datetime - 1

      creation_of_data_file < one_hour_ago
    end

    def data_file_exists?
      File.file?(data_file_location)
    end

    def find_data_file
      executable_location = `which recipe`
      project_root = executable_location.match(/(.*recipe-finder\/)/).captures.first

      "#{project_root}#{JSON_DATA_FILE}"
    end
  end
end
