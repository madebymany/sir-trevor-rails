require 'rails/generators'
require 'rails/generators/migration'

module SirTrevor
  module Generators
    class ImagesGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
        migration_template 'migration.rb', 'db/migrate/create_sirtrevor_image_table.rb'
      end

      def create_initializer_file
        template "initializer.rb", "config/initializers/sirtrevor.rb"
      end

    end
  end
end