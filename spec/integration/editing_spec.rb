require 'spec_helper'

class EditingSpec < ActionDispatch::IntegrationTest
  describe 'Edit form' do
    let(:post) { Post.create(body: blocks_json(:text_html)) }

    it 'serializes BlockArray to correct json' do
      visit edit_post_path(post)
      expect { find_field('Body').value == {data: post.body.as_json}.to_json }
    end

    it 'serializes empty BlockArray to empty array json' do
      post = Post.create()

      visit edit_post_path(post)
      expect { find_field('Body').value == "{\"data\":[]}" }
    end
  end
end
