class Presenter
  def present(recipe:)
    <<~STR
      #{recipe_info(recipe)}
      #{ingredients(recipe)}
      #{instructions(recipe)}
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
