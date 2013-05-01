module SirTrevor
  module Helpers
    module ViewHelper

      extend ActiveSupport::Concern
      include Twitter::Autolink
  
      def render_sir_trevor(json, image_type = 'large')
        if hash = parse_sir_trevor(json)
          hash.map { |object|
            render_sir_trevor_block(object, image_type)
          }.compact.join.html_safe
        else
          ''
        end
      end

      def render_sir_trevor_block(object, image_type = 'large')
        view_name = "sir-trevor/blocks/#{object['type'].to_s.downcase}_block"

        render(view_name,
               :block => object['data'],
               :image_type => image_type) if object.has_key?("data")
      end

      def render_sir_trevor_image(json, image_type = "large")
        image = pluck_sir_trevor_type(json, "image")
    
        unless image.nil? 
          render(:partial => "sir-trevor/blocks/image_block", :locals => {:block => image['data'], :image_type => image_type, :protocol => request.protocol}) if image.has_key?("data")
        end
      end
      
      def sir_trevor_image_tag(block, image_type) 
        # Does the image type exist on the block?
        if(block['file'].present? && block['file'][image_type].present?)
        
          image = block['file'][image_type]
        
          image_url = image['url']
          width = image['width'] if image['width'].present?
          height = image['height'] if image['height'].present?
          
          options = {
            :class => "sir-trevor-image #{image_type}",
            :alt => block['description'] 
          }
          
          options.merge!({ :width => width }) unless width.nil?
          options.merge!({ :height => height }) unless height.nil?
          
          image_tag(image_url, options) unless image_url.nil?
        end
      end

      def sir_trevor_markdown(text)
        options = {:hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code => true}
        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(CustomMarkdownFormatter)
        markdown.render(text).html_safe
      end

      def parse_sir_trevor(json)
        hash = JSON.parse(json)

        return false unless hash.has_key?("data")
        hash["data"]
      end

      private
        # Get's the first instance of a type from the specified JSON
        def pluck_sir_trevor_type(json, type) 
          hash = JSON.parse(json)
          if hash.has_key?("data")
            item = hash["data"].select { |item| item["type"] == type }
            item.first
          end
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
