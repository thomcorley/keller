require_relative "presenter"

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
    output = ""

    recipe.ingredient_entries.each do |ingredient_entry|
      output << "#{ingredient_entry}\n"
    end

    output
  end

  def instructions(recipe)
    output = ""

    recipe.instructions.each do |instruction|
      output << "#{instruction}\n\n"
    end

    output
  end
end

