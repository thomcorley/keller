require_relative "../../lib/local_data_source.rb"

describe LocalDataSource do
  let(:data_file_path) { "spec/fixtures/recipe_response.json" }
  let(:local_data_source) { described_class.new(data_file_path) }

  describe "#all_recipes" do
    it "returns an array of Recipe objects" do
      all_recipes = local_data_source.all_recipes

      expect(all_recipes).to be_a(Array)
      expect(all_recipes.first).to be_a(Recipe)
    end
  end

  describe "#stale?" do
    subject { local_data_source.stale? }

    context "when the data file is missing" do
      let(:local_data_source) { described_class.new("not/a/file") }
      it { is_expected.to be true }
    end
  end
end
