# frozen_string_literal: true

module Recipe
  class RecipeRep
    delegate :to_json, to: :recipe_hash

    def initialize(recipe_hash)
      @recipe_hash = recipe_hash
    end

    def ingredient_entries_array
      recipe_hash["ingredient_entries"].map do |ingredient_entry|
        ingredient_entry["original_string"]
      end
    end

    def instructions_array
      recipe_hash["method_steps"].map do |method_step|
        "#{method_step["position"]}. #{method_step["description"]}"
      end.reverse
    end

    def title
      recipe_hash["title"]
    end

    def serves
      recipe_hash["serves"]
    end

    def total_time
      recipe_hash["total_time"]
    end

    def summary
      recipe_hash["summary"]
    end

    private

    attr_reader :recipe_hash
  end
end
