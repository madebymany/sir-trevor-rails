require 'sir_trevor_rails/block_array'
require 'sir_trevor_rails/block'

module SirTrevorRails
  module HasSirTrevorContent
    extend ActiveSupport::Concern

    module ClassMethods
      def sir_trevor_content(*attributes)
        attributes.each do |attribute|
          #next unless name.constantize.column_names.include? attribute.to_s
          define_attribute_reader(attribute)
        end
      end

      private
      def define_attribute_reader(attribute)
        define_method attribute do
          content = read_attribute(attribute)
          return SirTrevorRails::BlockArray.new if content.blank?
          instance_variable_get("@#{attribute}") ||
            instance_variable_set("@#{attribute}", SirTrevorRails::BlockArray.from_json(content, self))
        end
      end
    end
  end
end
