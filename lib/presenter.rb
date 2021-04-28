class Presenter
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def present
    <<~STR
      #{recipe_info}
      #{ingredients}
      #{instructions}
    STR
  end

  private

  def recipe_info
    raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
  end

  def ingredients
    raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
  end

  def instructions
    raise NotImplementedError, "Abstract method #{__method__} must be defined in subclass"
  end
end
