require "tty-prompt"

# TODO: the name of this class could be improved
class RecipeSelector
  def initialize(recipes:)
    @recipes = recipes
  end

  def select
    prompt = TTY::Prompt.new
    choices_for_prompt = {}

    recipes.each do |recipe|
      choices_for_prompt[recipe.title] = recipe
    end

    selected_recipe = prompt.select("Found #{recipes.count} recipes:\n", choices_for_prompt)

    puts "Displaying recipe...\n\n"
    selected_recipe
  end

  private

  attr_reader :recipes
end
