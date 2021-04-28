module Recipe
  class Presenter
    attr_reader :recipe

    def initialize(recipe:)
      @recipe = recipe
    end

    def output
      <<~STR
        #{recipe_info}
        #{ingredients}
        #{instructions}
      STR
    end

    private

    def ingredient_entries_array
      recipe["ingredient_entries"].map do |ingredient_entry|
        ingredient_entry["original_string"]
      end
    end

    def instructions_array
      recipe["method_steps"].map do |method_step|
        "#{method_step["position"]}. #{method_step["description"]}"
      end.reverse
    end

    def recipe_info
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end

    def ingredients
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end

    def instructions
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end
  end
end
