require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  test "can parse ST data" do
    article = Article.new
    article.content = '[{"data": {"text": "asdf"}}]'
    assert { article.content.is_a?(SirTrevor::BlockArray) }
  end

end
