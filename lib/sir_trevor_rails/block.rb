require 'ostruct'

module SirTrevorRails
  class Block < OpenStruct

    def self.from_hash(hash, parent)
      hash = hash.deep_dup
      self.type_klass(hash).new(hash, parent)
    end

    def initialize(hash, parent)
      @as_json = hash
      @parent  = parent
      @type    = hash[:type].to_sym

      super(hash[:data])
    end

    attr_reader :parent, :type, :as_json

    def to_partial_path
      "sir-trevor/blocks/" << self.class.name.demodulize.underscore
    end

    private

    def self.block_class(type)
      klass_name = "#{type.to_s.camelize}Block"
      return SirTrevorRails::Blocks.const_get(klass_name)
      rescue NameError
        return SirTrevorRails::Blocks.const_set(klass_name, Class.new(Block))
    end

    def self.type_klass(hash)
      if self == Block
        block_class(hash[:type].to_sym)
      else
        self
      end
    end

  end
end