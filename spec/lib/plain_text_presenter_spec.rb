require_relative "../../lib/plain_text_presenter.rb"
require_relative "../recipe_response_helper.rb"

describe PlainTextPresenter do
  include RecipeResponseHelper

  describe "#present" do
    let(:presenter) { PlainTextPresenter.new }
    let(:recipe_data) { JSON.parse(stubbed_api_response).first }
    let(:recipe) { Recipe.new(recipe_data) }

    it "returns the expected text" do
      output = presenter.present(recipe: recipe)

      expected_output = <<~STR
        Title: Provençal Fish Soup
        Serves: 6
        Total time: PT14H
        Source: https://grubdaily.com
      STR

      expect(output).to match(expected_output)
    end
  end
end
