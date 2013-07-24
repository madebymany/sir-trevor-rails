module SirTrevor
  class BlockArray < Array

    HAS_TYPE_PATTERN = /\Ahas_(\w+)\?\z/

    def self.parse(unparsed)
      if unparsed.respond_to?(:to_str)
        unparsed = SirTrevor.parse_json(unparsed.to_str)
      end
      unparsed = unparsed[:data] if unparsed.is_a?(Hash)

      unless unparsed.is_a?(Array)
        raise ArgumentError, "Unrecognised block array: #{unparsed.inspect}"
      end

      new(unparsed.map! { |b| Block.from_hash b })
    end

    def method_missing(name, *args)
      if name =~ HAS_TYPE_PATTERN
        klass = Block.class_for_type($1)
        any? { |b| b.is_a? klass }
      end
    end

    def respond_to_missing?(name)
      !!(name =~ HAS_TYPE_PATTERN) or super
    end

  end

  class Block < OpenStruct
    TYPES = [:text, :image, :iframe, :truncation, :hero_image]

    def self.from_hash(hash)
      hash = hash.deep_dup
      klass = class_for_type(hash[:type]) || Block
      klass.new hash[:data]
    end

    def self.class_for_type(type)
      "SirTrevor::#{type.to_s.camelize}Block".safe_constantize
    end
  end

  class TextBlock < Block; end
  class ImageBlock < Block; end
  class IframeBlock < Block; end
  class TruncationBlock < Block; end
  class HeroImageBlock < ImageBlock; end

end

