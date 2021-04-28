class Finder
  attr_reader :data_store, :presenter_class

  def initialize(data_store:, presenter_class:)
    @data_store = data_store
    @presenter_class = presenter_class
  end

  # Presents a random recipe
  def sample
    presenter = presenter_class.new(recipe: data_store.sample_recipe)
    presenter.present
  end
end
