# frozen_string_literal: true
module Recipe
  class Presenter
    def output(recipe)
      <<~STR
        #{recipe_info(recipe)}
        #{ingredients(recipe)}
        #{instructions(recipe)}
      STR
    end

    private

    def recipe_info(recipe)
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end

    def ingredients(recipe)
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end

    def instructions(recipe)
      raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
    end
  end
end
