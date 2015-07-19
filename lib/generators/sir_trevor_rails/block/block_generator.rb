require 'rails/generators'

module SirTrevorRails
  module Generators
    class BlockGenerator < Rails::Generators::NamedBase

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def create_block

        # Copy the JS
        copy_file "_block.js", "app/assets/javascripts/sir_trevor/blocks/#{name}.js"

        gsub_file "app/assets/javascripts/sir_trevor/blocks/#{name}.js", /SirTrevor\.Blocks\.Example/, "SirTrevor.Blocks.#{name.capitalize}"
        gsub_file "app/assets/javascripts/sir_trevor/blocks/#{name}.js", /return "Example"/, "return '#{name.capitalize}'"
        gsub_file "app/assets/javascripts/sir_trevor/blocks/#{name}.js", /type: 'example'/, "type: '#{name.downcase}'"

        # Copy the HTML
        copy_file "_block.html.erb", "app/views/sir_trevor/blocks/_#{name}_block.html.erb"
        gsub_file "app/views/sir_trevor/blocks/_#{name}_block.html.erb", /\s(-block)/, " #{name}-block"
        gsub_file "app/views/sir_trevor/blocks/_#{name}_block.html.erb", /\s(_block)/, " #{name}_block"

        # Copy the BlockDecorator
        copy_file "_block.rb", "app/sir_trevor_blocks/#{name}_block.rb"
        gsub_file "app/sir_trevor_blocks/#{name}_block.rb", /ExampleBlock/, " #{name}Block"

      end

    end
  end
end
