require 'spec_helper'

module SirTrevorRails
  describe BlockArray do
    describe 'intialization' do
      subject { BlockArray }
      let(:text_block) { {type: 'text', data: {text: 'Lorem ipsum'}} }
      let(:heading_block) { {type: 'heading', data: {text: 'Heading 1'}} }

      it 'can be initialized with an empty JSON array' do
        array = subject.from_json('[]')
        expect { array.is_a? BlockArray }
      end

      it 'can be initialized with multiple block hashes' do
        json = [text_block, heading_block].to_json
        array = subject.from_json(json)

        expect { array.is_a? BlockArray }
        expect { array.size == 2 }
      end

      it 'can be initialized with a hash' do
        ar = subject.from_json({'data' => [{'type' => 'text',
                                            'data' => {'text' => 'asdf'}},
                                           {'type' => 'image'}]})
        expect { ar.is_a? BlockArray }
        expect { ar.first.type == :text }
        expect { ar.first.text == 'asdf' }
        expect { ar.last.type == :image }
      end

      it 'can be initialized with an array' do
        ar = subject.from_json([{'type' => 'text',
                                 'data' => {'text' => 'asdf'}},
                                {'type' => 'image'}])
        expect { ar.is_a? BlockArray }
        expect { ar.first.type == :text }
        expect { ar.first.text == 'asdf' }
        expect { ar.last.type == :image }
      end
    end

    describe 'instance methods' do
      let(:text_block) { {type: 'text', data: {text: 'First text block'}} }
      let(:other_text_block) { {type: 'text', data: {text: 'Other text block'}} }
      let(:image_block) { {type: 'image', data: {file: {url: 'http://example.com'}}} }
      let(:heading_block) { {type: 'heading', data: {text: 'Heading 1'}} }
      let(:json) { [image_block, text_block, heading_block, other_text_block].to_json }

      subject { BlockArray.from_json(json) }

      describe 'has_block_of_type?' do
        it 'can be called with nonexistent block type' do
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
          assert { block.text == 'First text block' }
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
