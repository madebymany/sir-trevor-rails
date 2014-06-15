module SirTrevorRails
  class BlockArray < Array

    def self.from_json(str, parent = nil)
      blocks = MultiJson.load(str, symbolize_keys: true)
      blocks = blocks[:data] if blocks.is_a?(Hash)
      blocks.map! { |block_obj| SirTrevorRails::Block.from_hash(block_obj, parent) }
      new blocks
    end

    def has_block_of_type?(type)
      klass = Block.block_class(type)
      any? { |b| b.is_a? klass }
    end

    def first_block_of_type(type)
      klass = Block.block_class(type)
      detect { |b| b.is_a? klass }
    end
  end
end
