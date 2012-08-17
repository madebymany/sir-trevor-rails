require 'rails/generators'

module SirTrevor
  module Generators
    class BlockGenerator < Rails::Generators::NamedBase

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def create_block
        
        # Copy our PNG
        copy_file "_block.png", "app/assets/images/sir-trevor/blocks/block_editor_#{name}.png"

        # Copy the JS
        copy_file "_block.js", "app/assets/javascripts/sir-trevor/blocks/#{name}.js"
        
        gsub_file "app/assets/javascripts/sir-trevor/blocks/#{name}.js", /var Name/, "var #{name.capitalize}"
        gsub_file "app/assets/javascripts/sir-trevor/blocks/#{name}.js", /title: ''/, "title: '#{name.capitalize}'"
        gsub_file "app/assets/javascripts/sir-trevor/blocks/#{name}.js", /className: ''/, "className: '#{name.downcase}'"
        gsub_file "app/assets/javascripts/sir-trevor/blocks/#{name}.js", /SirTrevor\.BlockTypes\.Name = new Name/, "SirTrevor.BlockTypes.#{name.capitalize} = new #{name.capitalize}"

        # Copy the CSS
        copy_file "_block.css.erb", "app/assets/stylesheets/sir-trevor/blocks/#{name}_block.css.erb"
        gsub_file "app/assets/stylesheets/sir-trevor/blocks/#{name}_block.css.erb", /_block\.png/, "#{name}_block.png"
        gsub_file "app/assets/stylesheets/sir-trevor/blocks/#{name}_block.css.erb", /a.new-/, "a.new-#{name}"
        gsub_file "app/assets/stylesheets/sir-trevor/blocks/#{name}_block.css.erb", /\.-block/, ".#{name}-block"
        
        # Copy the HTML
        copy_file "_block.html.erb", "app/views/sir-trevor/blocks/_#{name}_block.html.erb"
        gsub_file "app/views/sir-trevor/_#{name}_block.html.erb", /\s(-block)/, " #{name}-block"

      end

    end
  end
end