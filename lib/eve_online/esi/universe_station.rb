# frozen_string_literal: true

require "forwardable"

module EveOnline
  module ESI
    class UniverseStation < Base
      extend Forwardable

      API_PATH = "/v2/universe/stations/%<station_id>s/"

      attr_reader :station_id

      def initialize(options)
        super

        @station_id = options.fetch(:station_id)
      end

      def_delegators :model, :as_json, :max_dockable_ship_volume, :name,
        :office_rental_cost, :owner, :race_id, :reprocessing_efficiency,
        :reprocessing_stations_take, :services, :id, :system_id,
        :type_id, :position

      def model
        @model ||= Models::Station.new(response)
      end

      def scope
      end

      def path
        format(API_PATH, station_id: station_id)
      end
    end
  end
end
