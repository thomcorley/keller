require_relative "presenter"

class PlainTextPresenter < Presenter

  private

  def recipe_info
    <<~STR
      Title: #{recipe.title}
      Serves: #{recipe.serves}
      Total time: #{recipe.total_time}
      Source: https://grubdaily.com

      #{recipe.summary}
    STR
  end

  def ingredients
    output = ""

    recipe.ingredient_entries_array.each do |ingredient_entry|
      output << "#{ingredient_entry}\n"
    end

    output
  end

  def instructions
    output = ""

    recipe.instructions_array.each do |instruction|
      output << "#{instruction}\n\n"
    end

    output
  end
end

