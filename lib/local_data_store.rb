require_relative "recipe"

class LocalDataStore
  attr_reader :local_data_file, :data_source

  PATH = "data/recipe_data.json"

  def initialize(data_source:)
    @data_source = data_source
    @local_data_file = find_data_file
    refresh_local_data if needs_updating?
  end

  def recipes
    recipe_data.map { |recipe_hash| Recipe.new(recipe_hash: recipe_hash) }
  end

  def sample_recipe
    Recipe.new(recipe_hash: recipe_data.sample)
  end

  private

  def recipe_data
    @recipe_data ||= JSON.parse(File.read(local_data_file))
  end

  def refresh_local_data
    fresh_recipe_data = data_source.recipes

    File.open(local_data_file, "w+") do |file|
      file.write(fresh_recipe_data)
    end
  end

  def needs_updating?
    return true if !data_file_exists?
    creation_of_data_file = File.ctime(local_data_file).to_datetime
    one_hour_ago = Time.now.to_datetime - 1

    creation_of_data_file < one_hour_ago
  end

  def data_file_exists?
    File.file?(local_data_file)
  end

  def find_data_file
    executable_location = `which recipe`
    project_root = executable_location.match(/(.*recipe-finder\/)/).captures.first

    "#{project_root}#{PATH}"
  end
end
