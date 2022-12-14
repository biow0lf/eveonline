# frozen_string_literal: true

module EveOnline
  module ESI
    class CharacterAssetsNames < Base
      API_PATH = "/v1/characters/%<character_id>s/assets/names/"

      attr_reader :character_id, :item_ids

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
        @item_ids = options.fetch(:item_ids)
      end

      def assets_names
        @assets_names ||=
          begin
            output = []
            response.each do |asset_name|
              output << Models::AssetName.new(asset_name)
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
