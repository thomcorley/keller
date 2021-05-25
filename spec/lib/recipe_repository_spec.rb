require_relative "../../lib/recipe_repository.rb"

describe RecipeRepository do
  let(:local_source) { double("local data source") }
  let(:api_client) { double("api client") }
  let(:recipe_repository) { described_class.new(local_source, api_client) }

  describe "#all_recipes" do
    context "when the local data is stale" do
      before { allow(local_source).to receive(:stale?).and_return(true) }

      it "downloads new data from the API" do
        expect(api_client).to receive(:all_recipes)
        recipe_repository.all_recipes
      end
    end

    context "when the local data is fresh" do
      before { allow(local_source).to receive(:stale?).and_return(false) }

      it "accesses the data locally" do
        expect(local_source).to receive(:all_recipes)
        recipe_repository.all_recipes
      end
    end
  end
end
