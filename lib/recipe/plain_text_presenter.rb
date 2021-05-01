# frozen_string_literal: true

require "recipe/presenter"

module Recipe
  class PlainTextPresenter < Presenter

    private

    def recipe_info(recipe)
      <<~STR
        Title: #{recipe.title}
        Serves: #{recipe.serves}
        Total time: #{recipe.total_time}
        Source: https://grubdaily.com

        #{recipe.summary}
      STR
    end

    def ingredients(recipe)
      recipe.ingredient_entries_array.join("\n")
    end

    def instructions(recipe)
      recipe.instructions_array.join("\n")
    end
  end
end

