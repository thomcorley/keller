class RecipeRepository
  attr_reader :local_source, :api_client

  def initialize(local_source:, api_client:)
    @local_source = local_source
    @api_client = api_client
  end

  def all_recipes
    if local_source.stale?
      puts "Downloading recipe data...\n\n"
      api_client.all_recipes
    else
      puts "Accessing recipe data locally...\n\n"
      local_source.all_recipes
    end
  end
end
