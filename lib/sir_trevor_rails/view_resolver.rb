module SirTrevorRails
  class ViewResolver < ::ActionView::FileSystemResolver

    def initialize
      super("app/views")
    end

    def find_templates(name, prefix, partial, details)
      super(name, prefix.gsub(/^(.)+(sir_trevor)/, '\2'), partial, details)
    end

  end
end