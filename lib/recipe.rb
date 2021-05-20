class Recipe
  attr_reader :recipe_data

  def initialize(recipe_data)
    @recipe_data = recipe_data
  end

  def title
    recipe_data["title"]
  end

  def serves
    recipe_data["serves"]
  end

  def total_time
    recipe_data["total_time"]
  end

  def summary
    recipe_data["summary"]
  end

  def ingredient_entries
    recipe_data["ingredient_entries"].map do |ingredient_entry|
      ingredient_entry["original_string"]
    end
  end

  def instructions
    recipe_data["method_steps"].map do |method_step|
      "#{method_step["position"]}. #{method_step["description"]}"
    end.reverse
  end

  def to_hash
    recipe_data
  end
end
