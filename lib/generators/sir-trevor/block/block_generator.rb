require 'rails/generators'

module SirTrevor
  module Generators
    class BlockGenerator < Rails::Generators::NamedBase

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def create_block

        copy_file "_block.png", "app/assets/images/sedit/blocks/#{name}_block.png"

        copy_file "_block.js", "app/assets/javascripts/sedit/blocks/#{name}_block.js"
        gsub_file "app/assets/javascripts/sedit/blocks/#{name}_block.js", /title: ''/, "title: '#{name.capitalize}'"
        gsub_file "app/assets/javascripts/sedit/blocks/#{name}_block.js", /block_types\./, "block_types.#{name}"

        copy_file "_block.css.erb", "app/assets/stylesheets/sedit/blocks/#{name}_block.css.erb"
        gsub_file "app/assets/stylesheets/sedit/blocks/#{name}_block.css.erb", /_block\.png/, "#{name}_block.png"
        gsub_file "app/assets/stylesheets/sedit/blocks/#{name}_block.css.erb", /\.sedit_new_/, ".sedit_new_#{name}"
        gsub_file "app/assets/stylesheets/sedit/blocks/#{name}_block.css.erb", /\._block/, ".#{name}_block"

        copy_file "_block.html.erb", "app/views/sedit/blocks/_#{name}_block.html.erb"
        gsub_file "app/views/sedit/blocks/_#{name}_block.html.erb", /\s(_block)/, " #{name}_block"

      end

    end
  end
end