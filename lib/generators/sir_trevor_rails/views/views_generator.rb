require 'rails/generators'

module SirTrevorRails
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      def self.source_root
        @source_root ||= SirTrevorRails::Engine.root
      end

      def views
        directory "app/views/sir_trevor"
      end

    end
  end
end