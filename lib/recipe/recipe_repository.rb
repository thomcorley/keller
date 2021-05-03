# frozen_string_literal: true

module Recipe
  class RecipeRepository
    def initialize(local_source, api_client)
      @local_source = local_source
      @api_client = api_client
    end

    def all
      if local_source_stale?
        puts "Downloading recipe data...\n\n"
        recipes = api_client.all
        local_source.persist_all(recipes)
        recipes
      else
        puts "Accessing recipe data locally...\n\n"
        local_source.all
      end
    end

    private

    attr_reader :local_source, :api_client

    def local_source_stale?
      # This is a method which only talks about methods on local_source, so why is
      # it not a method on LocalRecipes? Maybe LocalRecipes#stale?
      # In this case it probably doesn't matter, but I think it's because
      # staleness isn't a property of LocalSource itself. We only know if a LocalSource
      # is stale by comparing it to external things, in this case the current time.
      # But let's say the logic was more complicated and staleness also depended on
      # a CLI flag that was passed in forcing a refresh - where would that check live?
      # If we implemented LocalRecipes#stale? we'd do something like
      #   local_source.stale? || cli_flags.force_refresh
      # here to see if we should refresh, but now "staleness"/refresh logic is shared between two
      # methods.
      #
      # With OOP we could create a new class which identifies the "staleness"
      # aspect of LocalRecipes, say RefreshableLocalRecipes. That would look like
      #  class RefreshableLocalRecipes
      #    delegate_missing_to :local_recipes
      #    def initialize(local_source, cli_flags); ... end
      #    def stale?
      #      return true if cli_flags.force_refresh
      #      return true unless local_source.present?
      #      ...
      #      local_source.created_at < one_hour_ago
      #    end
      #  end
      # keeping the higher order refresh/staleness logic out of LocalRecipes
      # and separate/isolated.
      return true unless local_source.present?

      one_hour_ago = Time.now.to_datetime - 1
      local_source.created_at < one_hour_ago
    end
  end
end
