# frozen_string_literal: true

module EveOnline
  module ESI
    class CharacterAssetsLocations < Base
      API_PATH = "/v2/characters/%<character_id>s/assets/locations/"

      attr_reader :character_id, :item_ids

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
        @item_ids = options.fetch(:item_ids)
      end

      def assets_locations
        @assets_locations ||=
          begin
            output = []
            response.each do |asset_location|
              output << Models::AssetLocation.new(asset_location)
            end
            output
          end
      end

      def http_method
        :post
      end

      def payload
        item_ids.to_json
      end

      def scope
        "esi-assets.read_assets.v1"
      end

      def path
        format(API_PATH, character_id: character_id)
      end
    end
  end
end
