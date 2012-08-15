require 'securerandom'

module SirTrevor
  module Helpers
    module FormHelper

      extend ActiveSupport::Concern
      
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
      
      def sir_trevor_text_area(object_name, method, options = {})

        element_id = "sir-trevor_#{ SecureRandom.hex(16) }"

        options = { :language => I18n.locale.to_s }.merge(options)
        input_html = (options.delete(:input_html) || {})
        input_html['class'] = "sir-trevor-area visuallyhidden"
        input_html['id'] = element_id
        hash = input_html.stringify_keys

        instance_tag = ActionView::Base::InstanceTag.new(object_name, method, self, options.delete(:object))
        instance_tag.send(:add_default_name_and_id, hash)
        
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << instance_tag.to_text_area_tag(input_html)
        
        output_buffer

      end

    end
  end
end