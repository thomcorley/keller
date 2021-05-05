require_relative "recipe_repository"
require_relative "local_data_source"
require_relative "api_client_with_syncing"
require_relative "plain_text_presenter"

class Cli
  DATA_FILE_PATH = "data/recipe_data.json"

  def sample
    recipe = recipe_repository.all_recipes.sample
    puts presenter.present(recipe: recipe)
  end

  private

  def recipe_repository
    RecipeRepository.new(
      local_source: local_source,
      api_client: ApiClientWithLocalSyncing.new(local_source)
    )
  end

  def local_source
    local_source ||= LocalDataSource.new(data_file_location)
  end

  def presenter
    PlainTextPresenter.new
  end

  def data_file_location
    executable_location = `which recipe`
    project_root = executable_location.match(/(.*recipe-finder\/)/).captures.first

    "#{project_root}#{DATA_FILE_PATH}"
  end
end
