require_relative "../../lib/cli.rb"

describe Cli do
  let(:cli) { Cli.new }

  describe "#sample" do
    before do
      $stdout = StringIO.new
      allow_any_instance_of(ApiClient).to receive(:all_recipes).and_return(recipe_response)
      allow_any_instance_of(LocalDataSource).to receive(:persist_all).and_return(true)
    end

    context "when the data source is stale" do
      before do
        allow_any_instance_of(LocalDataSource).to receive(:stale?).and_return(true)
        cli.sample
      end

      it "tells the user the data is downloaded from the API" do
        cli.sample
        expect($stdout.string).to match(/Downloading recipe data/)
      end

      it "outputs a recipe to the console" do
        cli.sample
        expect($stdout.string).to match(/Title: Provençal Fish Soup/)
      end
    end

    context "when the data source is not stale" do
      before do
        allow_any_instance_of(LocalDataSource).to receive(:stale?).and_return(false)
        allow_any_instance_of(LocalDataSource).to receive(:all_recipes).and_return(recipe_response)
        cli.sample
      end

      it "tells the user the data is accessed locally" do
        expect($stdout.string).to match(/Accessing recipe data locally/)
      end

      it "outputs a recipe to the console" do
        expect($stdout.string).to match(/Title: Provençal Fish Soup/)
      end
    end
  end

  def recipe_response
    stubbed_api_response = JSON.parse(File.read("spec/fixtures/recipe_response.json"))
    stubbed_api_response.map{ |recipe_data| Recipe.new(recipe_data) }
  end
end
