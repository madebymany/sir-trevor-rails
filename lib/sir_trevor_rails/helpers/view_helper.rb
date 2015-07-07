module SirTrevorRails
  module Helpers
    module ViewHelper
      extend ActiveSupport::Concern

      def sir_trevor_markdown(text)
        rndr = CustomMarkdownFormatter.new(hard_wrap: true, filter_html: true,
                                    autolink: true, no_intraemphasis: true,
                                    fenced_code: true)

        markdown = Redcarpet::Markdown.new(rndr)
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
