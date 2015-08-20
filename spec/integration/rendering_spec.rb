require 'spec_helper'

class RenderingSpec < ActionDispatch::IntegrationTest
  describe 'SirTrevorContent rendering' do
    it 'renders all blocks as separate divs' do
      post = Post.create(body: blocks_json(:list_html, :text_html))
      visit post_path(post)

      expect { all('.st__content-block').length == 2 }
    end
  end

  describe 'Text block' do
    it 'renders markdown format' do
      create_and_visit(blocks_json(:text_markdown))

      expect { find_block(:text).text == "One two three four" }
      expect { find_block(:text).find('em').text == "two" }
      expect { find_block(:text).find('strong').text == "three" }
      expect { find_block(:text).find('a').text == "four" }
    end

    it 'renders html format' do
      create_and_visit(blocks_json(:text_html))

      expect { find_block(:text).text == "One two three four" }
      expect { find_block(:text).find('i').text == "two" }
      expect { find_block(:text).find('b').text == "three" }
      expect { find_block(:text).find('a').text == "four" }
    end
  end

  describe 'List block' do
    it 'renders markdown format' do
      create_and_visit(blocks_json(:list_markdown))

      expect { find_block(:list).text == "List Item 1 List Item 2" }
      expect { find_block(:list).all('li').first.text == "List Item 1" }
      expect { find_block(:list).all('li').last.text == "List Item 2" }
      expect { find_block(:list).first('strong').text == "List Item 2" }
    end

    it 'renders html format' do
      create_and_visit(blocks_json(:list_html))

      expect { find_block(:list).text == "List Item 1 List Item 2" }
      expect { find_block(:list).all('li').first.text == "List Item 1" }
      expect { find_block(:list).all('li').last.text == "List Item 2" }
      expect { find_block(:list).first('b').text == "List Item 2" }
    end
  end

  describe 'Image block' do
    it 'renders correctly' do
      create_and_visit(blocks_json(:image))
      expect { find_block(:image).find("img")[:src] == "http://placeimg.com/1000/600/any" }
    end
  end

  describe 'Heading block' do
    it 'renders markdown format' do
      create_and_visit(blocks_json(:heading_markdown))

      expect { find_block(:heading).text == "Heading 1" }
      expect { find_block(:heading).find('em').text == "1" }
    end

    it 'renders html format' do
      create_and_visit(blocks_json(:heading_html))

      expect { find_block(:heading).text == "Heading 1" }
      expect { find_block(:heading).find('i').text == "1" }
    end
  end

  describe 'Quote block' do
    it 'renders markdown format' do
      create_and_visit(blocks_json(:quote_markdown))

      expect { find_block(:quote).find('blockquote').text == "This is quoted text" }
      expect { find_block(:quote).find('cite').text == "– Author" }
    end

    it 'renders html format' do
      create_and_visit(blocks_json(:quote_html))

      expect { find_block(:quote).find('blockquote').text == "This is quoted text" }
      expect { find_block(:quote).find('cite').text == "– Author" }
    end
  end

  describe 'Tweet block' do
    it 'renders correctly' do
      create_and_visit(blocks_json(:tweet))
      expect { find_block(:tweet).all('a')[0][:href] == "//twitter.com/SachseInTheCity" }
      expect { find_block(:tweet).find('img')[:src] == "//pbs.twimg.com/profile_images/613336689893896192/5nQjxG2o_normal.jpg" }

      expect { find_block(:tweet).find('p').text == "There's no pain without some gain ! let's run \\o/" }

      expect { find_block(:tweet).find('cite').text == "From @SachseInTheCity on Twitter:" }

      expect { find_block(:tweet).all('a')[1][:href] == "//twitter.com/SachseInTheCity" }
      expect { find_block(:tweet).all('a')[1].text == "@SachseInTheCity" }

      expect { find_block(:tweet).find('time')[:datetime] == "Tue Jun 30 11:38:31 +0000 2015" }
      expect { find_block(:tweet).find('time').text == "(#{Time.zone.parse("Tue Jun 30 11:38:31 +0000 2015")})" }

      expect { find_block(:tweet).all('a')[2][:href] == "https://twitter.com/SachseInTheCity/status/615846875078504448" }
      expect { find_block(:tweet).all('a')[2].text == Time.zone.parse("Tue Jun 30 11:38:31 +0000 2015").to_s }
    end
  end

  def create_and_visit(json)
    post = Post.create(body: json)
    visit post_path(post)
  end

  def find_block(type)
    first(".st__content-block--#{type}")
  end
end
