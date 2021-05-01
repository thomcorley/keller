# frozen_string_literal: true

module Recipe
  class GetFreshData
    def initialize(local_source, api_client)
      @local_source = local_source
      @api_client = api_client
    end

    def all
      if !local_source.present?
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
  end
end
