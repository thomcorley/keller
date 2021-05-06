require_relative "recipe"

class LocalDataSource
  attr_reader :data_file_path

  def initialize(data_file_path)
    @data_file_path = data_file_path
  end

  def all_recipes
    recipe_hash.map{ |recipe_data| Recipe.new(recipe_data)  }
  end

  def stale?
    return true unless present?

    one_day_ago = Time.now - 86400 # 1 day in seconds
    created_at < one_day_ago
  end

  # Takes a Hash of recipe data and saves it to file
  def persist_all(recipes_data)
    File.open(data_file_path, "w+") do |file|
      file.write(JSON.dump(recipes_data))
    end
  end

  private

  def recipe_hash
    JSON.parse(File.read(data_file_path))
  end

  def created_at
    File.ctime(data_file_path)
  end

  def present?
    File.file?(data_file_path)
  end
end
