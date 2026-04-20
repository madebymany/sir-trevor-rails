module SirTrevorRails
  module Helpers
    module ViewHelper
      extend ActiveSupport::Concern
      included do
        include ActionView::Helpers::SanitizeHelper
      end

      def sir_trevor_format(text, format: :markdown)
        if format.to_s.to_sym == :html
          sir_trevor_html(text)
        else
          sir_trevor_markdown(text)
        end
      end

      def sir_trevor_html(text)
        sanitize(text, tags: %w(b i a br p sup))
      end

      def sir_trevor_markdown(text)
        rndr = CustomMarkdownFormatter.new(hard_wrap: true, filter_html: true,
                                    autolink: true, no_intraemphasis: true,
                                    fenced_code: true)

        markdown = Redcarpet::Markdown.new(rndr)
        sanitize(markdown.render(text))
      end

      def without_p_wrap(html)
        stripped = html.to_s.strip
        return html unless stripped.start_with?('<p>') && stripped.end_with?('</p>')
        inner = stripped[3..-5]
        return html if inner.include?('<p>')
        sanitize(inner)
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
