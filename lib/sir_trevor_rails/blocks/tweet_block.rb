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

      def profile_image_url(size="bigger")
        "//twitter.com/api/users/profile_image/" << self.user[:screen_name] <<
          "?size=" << size
      end

    end
  end
end
