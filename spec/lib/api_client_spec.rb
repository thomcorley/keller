require_relative "../../lib/api_client.rb"
require_relative "../recipe_response_helper.rb"

describe ApiClient do
  include RecipeResponseHelper

  describe "#all_recipes" do
    before { allow(HTTParty).to receive_message_chain(:get, :body).and_return(stubbed_api_response) }

    it "returns an array of Recipe objects" do
      recipes = ApiClient.new.all_recipes

      expect(recipes).to be_a(Array)
      expect(recipes.first).to be_a(Recipe)
    end
  end
end

