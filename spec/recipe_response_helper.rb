module RecipeResponseHelper
  def stubbed_api_response
    File.read("spec/fixtures/recipe_response.json")
  end  

  def stubbed_client_response
    JSON.parse(stubbed_api_response).map{ |recipe_data| Recipe.new(recipe_data) }
  end
end
