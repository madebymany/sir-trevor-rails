require 'spec_helper'

module SirTrevorRails
  describe 'HasSirTrevorContent' do
    describe 'initialized for body field' do
      before do
        Post.send(:include, HasSirTrevorContent)
        Post.send(:sir_trevor_content, :body)
      end

      let(:post) { Post.new }
      let(:text_block) { {type: 'text', data: {text: 'Lorem ipsum'}} }

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
        post.body = [text_block].to_json

        assert { post.body.size == 1 }
        assert { post.body.first.is_a? Block }
      end
    end
  end
end
