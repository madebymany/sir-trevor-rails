require 'spec_helper'

module SirTrevorRails
  describe Helpers do
    let(:subject) { Class.new.include(Helpers::ViewHelper).new }

    describe 'sir_trevor_format' do
      it 'is callable' do
        expect { subject.respond_to? :sir_trevor_format }
      end

      it 'calls sir_trevor_markdown if format is not provided' do
        subject.stub :sir_trevor_markdown, 'markdown-called' do
          expect { subject.sir_trevor_format('test') == 'markdown-called' }
        end
      end

      it 'calls sir_trevor_markdown if format == markdown' do
        subject.stub :sir_trevor_markdown, 'markdown-called' do
          expect { subject.sir_trevor_format('test', format: :markdown) == 'markdown-called' }
        end
      end

      it 'calls sir_trevor_html if format == html' do
        subject.stub :sir_trevor_html, 'html-called' do
          expect { subject.sir_trevor_format('test', format: :html) == 'html-called' }
        end
      end
    end

    describe 'sir_trevor_html' do
      it 'removes not allowed html tags' do
        html = '<strong><i>Hello<br><a href="http://example.com/">World</a>!</i></strong>'
        escaped_html = "<i>Hello<br><a href=\"http://example.com/\">World</a>!</i>"
        expect { subject.sir_trevor_html(html) != html }
        expect { subject.sir_trevor_html(html) == escaped_html }
      end
      it 'retains formatting html tags' do
        html = '<b><i>Hello<br><a href="http://example.com/">World</a>!</i></b>'
        expect { subject.sir_trevor_html(html) == html }
      end
    end
  end
end
