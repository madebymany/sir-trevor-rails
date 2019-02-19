require 'ostruct'

module SirTrevorRails
  class Block < OpenStruct
    DEFAULT_FORMAT = :markdown

    def self.from_hash(hash, parent)
      hash = hash.deep_dup.with_indifferent_access
      self.type_klass(hash).new(hash, parent)
    end

    def format
      send(:[], :format).present? ? send(:[], :format).to_sym : DEFAULT_FORMAT
    end

    # Sets a list of custom block types to speed up lookup at runtime.
    def self.custom_block_types
      []
    end

    def initialize(hash, parent)
      @raw_data = hash
      @parent  = parent
      @type    = hash[:type].to_sym
      super(hash[:data])
    end

    attr_reader :parent, :type

    def to_partial_path
      "sir_trevor/blocks/" << self.class.name.demodulize.underscore
    end

    def as_json(*attrs)
      {
        type: @type.to_s,
        data: marshal_dump
      }
    end

    private

    # Infers the block class.
    # Safe lookup that tries to identify user created block class.
    #
    # @param [Symbol] type
    def self.block_class(type)
      type_name = type.to_s.camelize
      block_name = "#{type_name}Block"
      if custom_block_types.include?(type_name)
        begin
          block_name.constantize
        rescue NameError
          block_class!(block_name)
        end
      else
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
