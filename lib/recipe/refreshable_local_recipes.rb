# frozen_string_literal: true

module Recipe
  class RefreshableLocalRecipes
    delegate_missing_to :local_recipes

    def initialize(local_recipes)
      @local_recipes = local_recipes
    end

    def stale?
      return true unless local_recipes.present?

      one_hour_ago = Time.now.to_datetime - 1
      local_recipes.created_at < one_hour_ago
    end

    private

    attr_reader :local_recipes
  end
end
