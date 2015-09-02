require 'rails/generators'

module SirTrevorRails
  module Generators
    class BlockGenerator < Rails::Generators::NamedBase

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def create_block

        # Copy the JS
        template "_block.js.erb", "app/assets/javascripts/sir_trevor/blocks/#{file_name}.js"

        # Copy the HTML
        template "_block.html.erb", "app/views/sir_trevor/blocks/_#{file_name}_block.html.erb"

        # Copy the BlockDecorator
        template "_block.rb.erb", "app/sir_trevor_blocks/#{file_name}_block.rb"
      end

      private

      def file_name
        name.underscore
      end

      def block_name
        file_name.camelize
      end

      def css_class
        file_name.dasherize
      end
    end
  end
end
