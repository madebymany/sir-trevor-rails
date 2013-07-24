module SirTrevor

  if defined?(Rails)
    class Engine < Rails::Engine

      require 'redcarpet'
      require 'twitter-text'

      initializer "sir_trevor.load_app_instance_data" do |app|
        SirTrevor.setup do |config|
          config.app_root = app.root
        end
      end

      initializer "sir_trevor.helpers" do
        ActiveSupport.on_load :action_view do
          ActionView::Base.send :include, SirTrevor::Helpers::ViewHelper
          ActionView::Base.send :include, SirTrevor::Helpers::FormHelper
          ActionView::Helpers::FormBuilder.send :include, SirTrevor::Helpers::FormBuilder
        end
      end
    end
  end

  def self.config(&block)
    @@config ||= SirTrevor::Engine::Configuration.new
    yield @@config if block
    return @@config
  end

end
