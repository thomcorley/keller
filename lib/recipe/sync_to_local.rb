# frozen_string_literal: true

module Recipe
  class SyncToLocal
    delegate_missing_to :api_client

    def initialize(local_source, api_client)
      @local_source = local_source
      @api_client = api_client
    end

    def all
      api_client.all.tap { |recipes| local_source.persist_all(recipes) }
    end

    private

    attr_reader :local_source, :api_client
  end
end
