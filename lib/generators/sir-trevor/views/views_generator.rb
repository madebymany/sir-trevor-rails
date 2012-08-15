require 'rails/generators'

module SirTrevor
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      def self.source_root
        @source_root ||= SirTrevor::Engine.root
      end

      def views
        directory "app/views/sir-trevor/blocks"
      end

    end
  end
end