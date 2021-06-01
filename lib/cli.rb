require_relative "recipe_repository"
require_relative "local_data_source"
require_relative "api_client_with_syncing"
require_relative "api_client"
require_relative "plain_text_presenter"

class Cli
  DATA_FILE_PATH = "data/recipe_data.json"

  def sample
    recipe = recipe_repository.all_recipes.sample
    puts presenter.present(recipe: recipe)
  end

  private

  def recipe_repository
    RecipeRepository.new(local_source, api_client)
  end

  def local_source
    @local_source ||= LocalDataSource.new(full_data_file_path)
  end

  def api_client
    ApiClientWithSyncing.new(local_source, ApiClient.new)
  end

  def presenter
    PlainTextPresenter.new
  end

  # This allows the `recipe` command to be run from outside the project root
  def full_data_file_path
    executable_location = `which keller`
    project_root = executable_location.match(/(.*keller\/)/).captures.first

    "#{project_root}#{DATA_FILE_PATH}"
  end
end
