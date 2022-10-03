# frozen_string_literal: true

module EveOnline
  module ESI
    module Models
      class Category < Base
        def as_json
          {
            id: id,
            name: name,
            published: published
          }
        end

        def id
          options["category_id"]
        end

        def name
          options["name"]
        end

        def published
          options["published"]
        end

        def group_ids
          options["groups"]
        end
      end
    end
  end
end
