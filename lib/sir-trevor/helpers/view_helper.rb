module SirTrevor
  module Helpers
    module ViewHelper

      extend ActiveSupport::Concern
      include Twitter::Autolink
  
      def render_sir_trevor(json, image_type = "large", dimensions = { width: "624", height: "351" })
        hash = JSON.parse(json)

        extension = @mobile_device ? :mobile : :html
        formats = [extension, :html].uniq
        
        if hash.has_key?("data")
          hash["data"].map { |object|
            render(:partial => "sir-trevor/blocks/#{object["type"].to_s.downcase}_block", :locals => {:block => object['data'], :image_type => image_type, :dimensions => dimensions, :protocol => request.protocol}, :formats => formats) if object.has_key?("data")
          }.compact.join.html_safe
        else
          ''
        end

      end

      def markdown(text)
        options = {:hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code => true}
        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(CustomMarkdownFormatter)
        markdown.render(text).html_safe
      end

    end
  end
end

class CustomMarkdownFormatter < Redcarpet::Render::HTML
  def block_code(code, language)
    "<p>" << code << "</p>"
  end
  
  def codespan(code)
    code
  end
end