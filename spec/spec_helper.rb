require 'sir_trevor_rails'
require 'combustion'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'wrong/adapters/minitest'
require 'pry'

Combustion.initialize! :active_record, :action_view

Wrong.config.alias_assert :expect, override: true

MiniTest::Spec.class_eval do
  include Wrong::Assert
  include Wrong::Helpers
end
