# frozen_string_literal: true

require "recipe/recipe_details"

module Recipe
  class LocalRecipes
    def initialize(file_path)
      @file_path = file_path
    end

    def all
      @all ||= recipes_hash.map { |recipe| Recipe::RecipeDetails.new(recipe) }
    end

    def persist_all(recipes)
      File.open(file_path, "w+") do |file|
        file.write(JSON.dump(recipes))
      end
    end

    def present?
      data_file_exists?
    end

    private

    attr_reader :file_path

    def recipes_hash
      JSON.parse(File.read(file_path))
    end

    def data_file_missing_or_needs_refreshed?
      return true unless data_file_exists?

      creation_of_data_file = File.ctime(file_path).to_datetime
      one_hour_ago = Time.now.to_datetime - 1

      creation_of_data_file < one_hour_ago
    end

    def data_file_exists?
      File.file?(file_path)
    end
  end
end
