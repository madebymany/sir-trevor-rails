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
      "sir_trevor/blocks/" << self.class.name.demodulize.underscore
    end

    private

    # Infers the block class.
    # Safe lookup that tries to identify user created block class.
    #
    # @param [Symbol] type
    def self.block_class(type)
      block_name = "#{type.to_s.camelize}Block"
      begin
        block_name.constantize
      rescue NameError
        block_class!(block_name)
      end
    end

    # Infers the block class.
    # Failover from block_class.
    # Safe lookup against the SirTevor::Blocks namespace
    # If no block is found, create one with given name and inherit from Block class
    #
    # @param [Constant] block_name
    def self.block_class!(block_name)
      begin
        SirTrevorRails::Blocks.const_get(block_name)
      rescue NameError
        SirTrevorRails::Blocks.const_set(block_name, Class.new(Block))
      end
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
