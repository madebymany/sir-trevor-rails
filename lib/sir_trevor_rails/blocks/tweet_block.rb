require 'twitter-text'

module SirTrevorRails
  module Blocks
    class TweetBlock

      def render_tweet_body
        sanitize Twitter::Autolink.auto_link(
              self.text,
              url_entities: (tweet_block.entities.values_at(:urls, :media).flatten.compact.uniq rescue nil)
            ), tags: %w{a span}, attributes: %w{class href rel target}
      end

      def status_url
        "//twitter.com/" << screen_name << "/status/" << self.id_str
      end

      def profile_url
        "//twitter.com/" << self.user[:screen_name]
      end

      def screen_name
        self.tweet_block.user[:screen_name]
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