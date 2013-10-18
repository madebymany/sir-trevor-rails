module SirTrevor
  module Helpers
    module FormHelper

      extend ActiveSupport::Concern
      
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
      
      def sir_trevor_text_area(object_name, method, options = {})

        options = { :language => I18n.locale.to_s }.merge(options)
        input_html = (options.delete(:input_html) || {})
        input_html['class'] = "sir-trevor-area visuallyhidden"
        hash = input_html.stringify_keys


        #https://github.com/mjhoy/ckeditor/commit/fca24021e13d355f74c9538f9db27dc58687ce65
        if defined?(ActionView::Base::InstanceTag)
          instance_tag = ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object))
          instance_tag.send(:add_default_name_and_id, hash)
          output = instance_tag.to_text_area_tag(input_html)
        else
          instance_tag = ActionView::Helpers::Tags::TextArea.new(object_name, method, self, input_html)
          instance_tag.send(:add_default_name_and_id, hash)
          output = instance_tag.render
        end

        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << output
        output_buffer

      end
    end
  end
end

         
