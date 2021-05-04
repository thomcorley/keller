# frozen_string_literal: true

module Recipe
  class RecipeRepository
    def initialize(local_source, api_client)
      @local_source = local_source
      @api_client = api_client
    end

    def all
      if local_source.stale?
        puts "Downloading recipe data...\n\n"
        api_client.all
      else
        puts "Accessing recipe data locally...\n\n"
        local_source.all
      end
    end

    private

    attr_reader :local_source, :api_client
  end
end
