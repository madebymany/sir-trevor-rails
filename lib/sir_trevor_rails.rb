require "sir_trevor_rails/version"
require "sir_trevor_rails/engine"
require 'sir_trevor_rails/has_sir_trevor_content'

module SirTrevorRails

  mattr_accessor :app_root

  module Helpers
    autoload :ViewHelper, 'sir_trevor_rails/helpers/view_helper'
  end

  module Blocks
    autoload :TweetBlock, 'sir_trevor_rails/blocks/tweet_block'
    autoload :VideoBlock, 'sir_trevor_rails/blocks/video_block'
  end

  def self.setup
    yield self
  end

end