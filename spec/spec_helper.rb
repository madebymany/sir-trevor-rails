require 'logger'
require 'sir_trevor_rails'
require 'bundler'

Bundler.require :default, :development

require 'combustion'

Combustion.initialize! :active_record, :action_view do
  config.active_support.test_order = :random
end


require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'wrong/assert'
require 'wrong/helpers'
require 'pry'

Wrong.config.alias_assert :expect, override: true

# Patch Wrong::Assert in-place to work with modern Minitest:
# - failure_class: MiniTest::Assertion → Minitest::Assertion
# - increment_assertion_count: _assertions was renamed to assertions in Minitest 5.27
Wrong::Assert.module_eval do
  def failure_class
    Minitest::Assertion
  end

  def increment_assertion_count
    if respond_to?(:assertions)
      self.assertions += 1
    elsif respond_to?(:_assertions)
      self._assertions += 1
    end
  end
end

Minitest::Spec.class_eval do
  include Wrong::Assert
  include Wrong::Helpers
end

module SirTrevorRails::Fixtures
  def blocks_json(*names)
    "[" + names.map { |name| block_json(name) }.join(',') + "]"
  end

  def block_json(name)
    filename = File.join('fixtures', 'blocks', name.to_s + '.json')
    path = File.expand_path(filename, File.dirname(__FILE__))

    File.read(path)
  end

  def block_hash(name)
    MultiJson.load(block_json(name))
  end

  def blocks_hash(*names)
    MultiJson.load(blocks_json(*names))
  end
end

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL
  include Wrong::Assert
  include Wrong::Helpers

  include SirTrevorRails::Fixtures
  include SirTrevorRails # bad, but we don't have to use full class names
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end
