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
      # Should also invalidate any cache we have e.g. @all
      # Can also track a dirty flag
      File.open(file_path, "w+") do |file|
        file.write(JSON.dump(recipes))
      end
    end

    def present?
      data_file_exists?
    end

    def created_at
      File.ctime(file_path).to_datetime
    end

    private

    attr_reader :file_path

    def recipes_hash
      JSON.parse(File.read(file_path))
    end

    def data_file_exists?
      File.file?(file_path)
    end
  end
end
