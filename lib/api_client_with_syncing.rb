require "forwardable"

class ApiClientWithSyncing
  extend Forwardable

  def_delegator :@api_client, :all_recipes_hash

  attr_reader :api_client, :data_store

  def initialize(data_store, api_client)
    @data_store = data_store
    @api_client = api_client
  end

  def all_recipes
    data_store.persist_all(all_recipes_hash)
    api_client.all_recipes
  end
end
