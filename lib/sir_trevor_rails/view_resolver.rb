module SirTrevorRails
  class ViewResolver < ::ActionView::FileSystemResolver

    def initialize
      super("app/views")
    end

    def find_templates(name, prefix, partial, details)
      super(name, 'sir-trevor/blocks', partial, details)
    end

  end
end