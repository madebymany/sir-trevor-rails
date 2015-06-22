require 'spec_helper'

class HasSirTrevorContentSpec < ActiveSupport::TestCase
  describe 'HasSirTrevorContent' do
    describe 'initialized for body field' do
      let(:post) { Post.new }

      it 'returns BlockArray for initialised field' do
        assert { post.body.is_a? BlockArray }
      end

      it 'returns empty BlockArray if field is null' do
        post.body = nil

        assert { post.body.empty? }
      end

      it 'returns empty BlockArray if field is empty JSON array' do
        post.body = [].to_json

        assert { post.body.empty? }
      end

      it 'returns blocks if field is SirTrevor JSON' do
        post.body = blocks_json(:text_html)

        assert { post.body.size == 1 }
        assert { post.body.first.is_a? Block }
      end
    end
  end
end
