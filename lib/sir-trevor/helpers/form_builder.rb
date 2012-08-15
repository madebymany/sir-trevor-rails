module SirTrevor
  module Helpers
    module FormBuilder
      extend ActiveSupport::Concern
      
      def sir_trevor_text_area(method, options = {})
        @template.send("sir_trevor_text_area", @object_name, method, objectify_options(options))
      end
    end
  end
end