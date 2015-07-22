module SirTrevorRails
  class BlockArray < Array

    def self.from_json(blocks, parent = nil)
      if blocks.is_a?(String)
        blocks = MultiJson.load(blocks, symbolize_keys: true)
      end

      if blocks.is_a?(Hash)
        blocks = blocks[:data] || blocks['data'] or
          raise IndexError, "No block data found"
      end

      new blocks.map { |obj|
        SirTrevorRails::Block.from_hash(obj.deep_symbolize_keys, parent)
      }
    end

    def to_s
      {data: as_json}.to_json
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
