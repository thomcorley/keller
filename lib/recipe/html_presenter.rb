require "recipe/presenter"

module Recipe
  class HtmlPresenter < Presenter

    private

    def recipe_info(recipe)
      <<~STR
        <h1>#{recipe.title}</h1>
        <p>Serves: #{recipe.serves}</p>
        <p>Total time: #{recipe.total_time}</p>
        <p>Source: https://grubdaily.com</p>

        <p>#{recipe.summary}</p>
      STR
    end

    def ingredients(recipe)
      output = ""

      recipe.ingredient_entries_array.map do |ingredient_entry|
        output << "<li>#{ingredient_entry}</li>"
      end

      "<ul>#{output}</ul>"
    end

    def instructions(recipe)
      output = ""

      recipe.instructions_array.each do |instruction|
        instruction_without_number = instruction.sub(/\d\.\s/, "")

        output << "<li>#{instruction_without_number}</li>"
      end

      "<ol>#{output}</ol>"
    end
  end
end

