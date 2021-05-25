require_relative "../../lib/api_client_with_syncing.rb"
require_relative "../recipe_response_helper.rb"

describe ApiClientWithSyncing do
  include RecipeResponseHelper

  let(:data_store) { double("LocalDataSource") }
  let(:api_client) { double("ApiClient") }
  let(:api_client_with_syncing) { ApiClientWithSyncing.new(data_store, api_client) }

  before do
    allow(data_store).to receive(:persist_all)
    allow(api_client).to receive(:all_recipes).and_return(stubbed_client_response)
  end


  describe "#all_recipes" do
    it "delegates to ApiClient" do
      expect(api_client).to receive(:all_recipes)
      api_client_with_syncing.all_recipes
    end

    it "calls #persist_all on the data store" do
      recipe_data_for_persisting = stubbed_client_response.map{ |recipe| recipe.to_hash }
      expect(data_store).to receive(:persist_all).with(recipe_data_for_persisting)

      api_client_with_syncing.all_recipes
    end
  end
end

