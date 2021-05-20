class ApiClientWithSyncing
  attr_reader :api_client, :data_store

  def initialize(data_store, api_client)
    @data_store = data_store
    @api_client = api_client
  end

  def all_recipes
    @fresh_recipes_from_api = api_client.all_recipes
    persist_recipes

    @fresh_recipes_from_api
  end

  private

  def persist_recipes
    recipe_data = @fresh_recipes_from_api.map{ |recipe| recipe.to_hash }
    data_store.persist_all(recipe_data)
  end
end
