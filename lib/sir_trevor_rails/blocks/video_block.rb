module SirTrevorRails
  module Blocks
    class VideoBlock < SirTrevorRails::Block
      def to_partial_path
        "sir_trevor/blocks/videos/" << (self.source || 'youtube')
      end
    end
  end
end
