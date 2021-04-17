class RecipePresenter
  attr_reader :recipe_data

  def initialize(recipe_data:)
    @recipe_data = recipe_data
  end

  def present
    output = <<~STR
      #{recipe}
      #{ingredient_entries}
      #{method_steps}
    STR

    print output
  end

  private

  def recipe
    <<~STR
      #{recipe_data["title"]}

      Serves: #{recipe_data["serves"]}
      Total time: #{recipe_data["total_time"]}
      Source: https://grubdaily.com

      #{recipe_data["summary"]}
    STR
  end

  def ingredient_entries
    String.new.tap do |string|
      recipe_data["ingredient_entries"].each do |ingredient_entry|
        string << "#{ingredient_entry["original_string"]}\n"
      end
    end
  end

  def method_steps
    String.new.tap do |string|
      recipe_data["method_steps"].each_with_index do |method_step, index|
        string << "#{index + 1}. #{method_step["description"]}\n\n"
      end
    end
  end
end
