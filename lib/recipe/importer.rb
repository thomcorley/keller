# frozen_string_literal: true

module Recipe
  class Importer
    JSON_RECIPES_ENDPOINT = "http://api.grubdaily.com/recipes"

    def initialize(api_client, data_file_location)
      @api_client = api_client
      @data_file_location = data_file_location
    end

    def import
      if data_file_missing_or_needs_refreshed?
        download_recipe_data
      else
        parse_local_recipe_data
      end
    end

    attr_reader :data_file_location

    private

    attr_reader :api_client

    def download_recipe_data
      puts "Downloading recipe data...\n\n"
      recipes = api_client.recipes

      File.open(data_file_location, "w+") do |file|
        file.write(JSON.dump(recipes))
      end
    end

    def parse_local_recipe_data
      puts "Accessing recipe data locally...\n\n"
      JSON.parse(File.read(data_file_location))
    end

    def data_file_missing_or_needs_refreshed?
      return true unless data_file_exists?

      creation_of_data_file = File.ctime(data_file_location).to_datetime
      one_hour_ago = Time.now.to_datetime - 1

      creation_of_data_file < one_hour_ago
    end

    def data_file_exists?
      File.file?(data_file_location)
    end
  end
end
