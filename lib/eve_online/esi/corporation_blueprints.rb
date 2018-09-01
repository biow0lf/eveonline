# frozen_string_literal: true

module EveOnline
  module ESI
    class CorporationBlueprints < Base
      API_ENDPOINT = 'https://esi.evetech.net/v2/corporations/%<corporation_id>s/blueprints/?datasource=%<datasource>s&page=1'

      attr_reader :corporation_id

      def initialize(options)
        super

        @corporation_id = options.fetch(:corporation_id)
      end

      def blueprints
        output = []
        response.each do |blueprint|
          output << Models::Blueprint.new(blueprint)
        end
        output
      end
      memoize :blueprints

      def scope
        'esi-corporations.read_blueprints.v1'
      end

      def url
        format(API_ENDPOINT, corporation_id: corporation_id, datasource: datasource)
      end
    end
  end
end
