module EveOnline
  module SDE
    class Blueprint
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def as_json
        {
          blueprint_type_id: blueprint_type_id,
          max_production_limit: max_production_limit
        }
      end

      def blueprint_type_id
        options.fetch('blueprintTypeID')
      end

      def max_production_limit
        options.fetch('maxProductionLimit')
      end
    end
  end
end
