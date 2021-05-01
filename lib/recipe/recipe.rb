# frozen_string_literal: true

module Recipe
  class Recipe
    def initialize(recipe_hash)
      @recipe_hash = recipe_hash
    end

    def to_json(*args)
      recipe_hash.to_json(*args)
    end

    private

    attr_reader :recipe_hash
  end
end
