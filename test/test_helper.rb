require 'bundler/setup'
Bundler.require :default, :test
require 'test/unit'
require 'active_record'
require 'turn/autorun'
require 'wrong/adapters/minitest'
require 'sir-trevor-rails'

Turn.config.natural = true
Wrong.config.color


class ActiveSupport::TestCase
  setup do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )

    load "./test/migrate.rb"
  end
end

class Article < ActiveRecord::Base
  include SirTrevor::Model
  has_sir_trevor_data :content
end

