require 'spec_helper'

# The block that is being tested here is defined in
# `spec/internal/app/models/custom_block.rb`, just like it would in real 
# Rails app.

class CustomBlockTest < ActiveSupport::TestCase
  describe CustomBlock do
    describe "SirTrevorRails::Block" do
      let(:custom_block_hash) { {type: 'custom', data: {text: 'Body', title: 'name'}} }

      it 'initialises class defined in the file' do
        block = SirTrevorRails::Block.from_hash(block_hash(:custom), nil)

        assert { block.is_a? CustomBlock }
        assert { block.respond_to? :upcase_title }
        assert { block.upcase_title == "NAME" }
      end
    end
  end
end
