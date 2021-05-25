require_relative "../../lib/recipe.rb"
require_relative "../recipe_response_helper.rb"

describe Recipe do
  include RecipeResponseHelper

  let(:recipe_data) { JSON.parse(stubbed_api_response).first }
  let(:recipe) { Recipe.new(recipe_data) }

  it "has the expected recipe attributes" do
    expect(recipe.title).to eq("Provençal Fish Soup")
    expect(recipe.serves).to eq(6)
    expect(recipe.total_time).to eq("PT14H")
    expect(recipe.summary).to match(/One of my favourite things to do with fish/)
  end

  context "ingredient entries" do
    let(:ingredient_entries) { recipe.ingredient_entries }

    it "is an array of strings" do
      expect(ingredient_entries).to be_a(Array)
      expect(ingredient_entries.first).to be_a(String)
    end

    it "has the expected ingredient data" do
      expect(recipe.ingredient_entries.first).to eq("1kg small white fish, such as John Dory or bream")
    end
  end

  it "has instructions" do
    expect(recipe.instructions).to be_a(Array)
    expect(recipe.instructions.first).to match(/Using a pair of kitchen scissors/)
  end

  describe "#to_hash" do
    it "returns a Hash of recipe data" do
      recipe_hash = recipe.to_hash
      expect(recipe_hash).to be_a(Hash)
      expect(recipe_hash).to eq(recipe_data)
      expect(recipe_hash["title"]).to eq("Provençal Fish Soup")
    end
  end
end
