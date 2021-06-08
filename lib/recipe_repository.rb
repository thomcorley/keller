class RecipeRepository
  attr_reader :local_source, :api_client

  def initialize(local_source, api_client)
    @local_source = local_source
    @api_client = api_client
  end

  # Returns: an array of Recipe objects
  def all_recipes
    if local_source.stale?
      puts "Downloading recipe data...\n\n"
      api_client.all_recipes
    else
      puts "Accessing recipe data locally...\n\n"
      local_source.all_recipes
    end
  end

  def recipes_with(ingredients:)
    all_recipes.select do |recipe|
      ingredients.all? { |ingredient| recipe.contains?(ingredient) }
    end
  end
end
