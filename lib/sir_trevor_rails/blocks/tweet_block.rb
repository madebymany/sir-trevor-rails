require 'twitter-text'

module SirTrevorRails
  module Blocks
    class TweetBlock < SirTrevorRails::Block

      include ActionView::Helpers::SanitizeHelper

      def render_tweet_body
        sanitize Twitter::Autolink.auto_link(
              self.text,
              url_entities: (self.entities.values_at(:urls, :media).flatten.compact.uniq rescue nil)
            ), tags: %w{a span}, attributes: %w{class href rel target}
      end

      def profile_url
        "//twitter.com/" << self.user[:screen_name]
      end

      def screen_name
        self.user[:screen_name]
      end

      def at_name
        "@" << screen_name
      end

      def profile_image_url
        # TODO: add support for different size images: https://dev.twitter.com/overview/general/user-profile-images-and-banners

        # Split the URL to omit the protocol and let the browser define the context (note: assumes asset is available over both HTTP and HTTPS) 
        "//" << self.user[:profile_image_url].split("://")[1]
      end

    end
  end
end
