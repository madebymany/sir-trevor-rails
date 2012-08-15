require "active_support/dependencies"

module SirTrevor

	mattr_accessor :app_root

	autoload :ImageSizes, 'sir-trevor/image_sizes'

  module Helpers
    autoload :ViewHelper, 'sir-trevor/helpers/view_helper'
    autoload :FormHelper, 'sir-trevor/helpers/form_helper'
    autoload :FormBuilder, 'sir-trevor/helpers/form_builder'
  end

  def self.setup
  	yield self
  end

end

require "sir-trevor/engine"