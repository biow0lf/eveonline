# frozen_string_literal: true

require 'forwardable'

module EveOnline
  module ESI
    class CharacterFatigue < Base
      extend Forwardable

      API_ENDPOINT = 'https://esi.evetech.net/v1/characters/%<character_id>s/fatigue/?datasource=%<datasource>s'

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
      end

      def_delegators :model, :as_json, :jump_fatigue_expire_date,
                     :last_jump_date, :last_update_date

      def model
        Models::Fatigue.new(response)
      end
      memoize :model

      def scope
        'esi-characters.read_fatigue.v1'
      end

      def url
        format(API_ENDPOINT, character_id: character_id, datasource: datasource)
      end
    end
  end
end
