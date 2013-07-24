module SirTrevor
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def has_sir_trevor_data(field, options = {})
        define_method field do
          @sir_trevor_data ||= {}
          @sir_trevor_data[field] ||=
            SirTrevor::BlockArray.parse(read_attribute(field))
        end

        define_method :"#{field}=" do |new_data|
          @sir_trevor_data ||= {}
          @sir_trevor_data[field] = SirTrevor::BlockArray.parse(new_data)
          if new_data.respond_to?(:to_str)
            new_data = SirTrevor.parse_json(new_data.to_str)
          end
        end
      end
    end
  end
end
