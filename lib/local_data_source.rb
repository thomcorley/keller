require_relative "recipe"
require "json"

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

  def persist_all(data_hash)
    File.open(data_file_path, "w+") do |file|
      file.write(JSON.dump(data_hash))
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
