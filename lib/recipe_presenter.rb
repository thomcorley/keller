class RecipePresenter
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def present
    output = <<~STR
      #{recipe_info}
      #{ingredients}
      #{instructions}
    STR

    print output
  end

  private

  def recipe_info
    <<~STR
      #{recipe["title"]}

      Serves: #{recipe["serves"]}
      Total time: #{recipe["total_time"]}
      Source: https://grubdaily.com

      #{recipe["summary"]}
    STR
  end

  def ingredients
    String.new.tap { |string| ingredient_entries(string) }
  end

  def instructions
    String.new.tap { |string| method_steps(string) }
  end

  def ingredient_entries(string)
    recipe["ingredient_entries"].each do |ingredient_entry|
      string << "#{ingredient_entry["original_string"]}\n"
    end
  end

  def method_steps(string)
    recipe["method_steps"].each_with_index do |method_step, index|
      string << "#{index + 1}. #{method_step["description"]}\n\n"
    end
  end
end
