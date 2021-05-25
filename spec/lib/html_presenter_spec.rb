require_relative "../../lib/html_presenter.rb"
require_relative "../recipe_response_helper.rb"

describe HtmlPresenter do
  include RecipeResponseHelper

  describe "#present" do
    let(:presenter) { HtmlPresenter.new }
    let(:recipe_data) { JSON.parse(stubbed_api_response).first }
    let(:recipe) { Recipe.new(recipe_data) }

    it "returns the expected HTML" do
      output = presenter.present(recipe: recipe)

      expected_output = <<~STR
        <h1>Provençal Fish Soup</h1>
        <p>Serves: 6</p>
        <p>Total time: PT14H</p>
        <p>Source: https://grubdaily.com</p>
      STR

      expect(output).to match(expected_output)
    end
  end
end
