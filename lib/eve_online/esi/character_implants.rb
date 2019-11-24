# frozen_string_literal: true

module EveOnline
  module ESI
    class CharacterImplants < Base
      API_PATH = "/v1/characters/%<character_id>s/implants/"

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
      end

      def implant_ids
        response
      end

      def scope
        "esi-clones.read_implants.v1"
      end

      def path
        format(API_PATH, character_id: character_id)
      end
    end
  end
end
