require 'spec_helper'

class BlockArraySpec < ActiveSupport::TestCase
  describe BlockArray do
    describe 'intialization' do
      subject { BlockArray }

      it 'can be initialized with an empty JSON array' do
        array = subject.from_json('[]')
        expect { array.is_a? BlockArray }
      end

      it 'can be initialized with multiple block hashes' do
        array = subject.from_json(blocks_json(:text_html, :heading_html))

        expect { array.is_a? BlockArray }
        expect { array.size == 2 }
      end

      it 'can be initialized with a hash' do
        ar = subject.from_json({data: blocks_hash(:text_html, :image)})

        expect { ar.is_a? BlockArray }
        expect { ar.first.type == :text }
        expect { ar.last.type == :image }
      end

      it 'can be initialized with an array' do
        ar = subject.from_json(blocks_hash(:text_html, :image))

        expect { ar.is_a? BlockArray }
        expect { ar.first.type == :text }
        expect { ar.last.type == :image }
      end
    end

    describe 'instance methods' do
      let(:json) { blocks_json :image, :text_html, :heading_html, :text_markdown }

      subject { BlockArray.from_json(json) }

      describe 'has_block_of_type?' do
        it 'can be called with nonexistent block type' do
          # no assert needed, if anything was wrong it would raise an exception
          subject.has_block_of_type? :nonexistent
        end

        it 'returns true if block exists in the array' do
          assert { subject.has_block_of_type?(:text) }
        end

        it 'returns false if block doesn\'t exist in the array' do
          deny { subject.has_block_of_type?(:tweet) }
        end
      end

      describe 'first_block_of_type' do
        it 'returns first block of given type in the array' do
          block = subject.first_block_of_type(:text)
          assert { block.text.starts_with? "One <i>two</i>" }
        end

        it 'returns nil if called with block type not in the array' do
          assert { subject.first_block_of_type(:nonexistent).nil? }
        end
      end

      describe 'to_a' do
        it 'returns array with same number of elements' do
          assert { subject.to_a.class == Array }
          assert { subject.to_a.size == subject.size }
        end
      end
    end
  end
end
