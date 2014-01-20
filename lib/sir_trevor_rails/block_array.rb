module SirTrevorRails
  class BlockArray < Array

    def self.from_json(str, parent)
      blocks = MultiJson.load(str, symbolize_keys: true)
      blocks = blocks[:data] if blocks.is_a?(Hash)
      blocks.map! { |block_obj| SirTrevorRails::Block.from_hash(block_obj, parent) }
      new blocks
    end

    def has_block_of_type?(type)
      any? { |b| b.is_a?(block_constant(type)) }
    end

    def first_block_of_type(type)
      detect? { |b| b.is_a?(block_constant(type)) }
    end

    private

    def block_constant(type)
      "SirTrevorRails::#{type.to_s.camelize}Block".constantize
    end

  end
end
