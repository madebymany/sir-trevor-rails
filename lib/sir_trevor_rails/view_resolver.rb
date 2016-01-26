module SirTrevorRails
  class ViewResolver < ::ActionView::FileSystemResolver

    def initialize
      super("app/views")
    end

    def find_templates(name, prefix, *args)
      super(name, prefix.gsub(/^(.)+(sir_trevor)/, '\2'), *args)
    end

  end
end
