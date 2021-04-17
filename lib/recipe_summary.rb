# Takes raw data for a single recipe and converts it into a summarised recipe
# object
class RecipeSummary
  attr_reader :recipe_data

  def initialize(recipe_data:)
    @recipe_data = recipe_data
  end

  def to_json
    {
      title: recipe_data["title"],
      ingredient_count: ingredient_count
    }
  end

  private

  def ingredient_count
    recipe_data["ingredient_entries"].count
  end
end
