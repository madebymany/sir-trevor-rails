module SirTrevor

  class Engine < Rails::Engine

    require 'redcarpet'
    require 'twitter-text'
    require 'carrierwave'

    initializer "sedit.load_app_instance_data" do |app|
      Sedit.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "sirtrevor.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer "sirtrevor.helpers" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, SirTrevor::Helpers::ViewHelper
        ActionView::Base.send :include, SirTrevor::Helpers::FormHelper
        ActionView::Helpers::FormBuilder.send :include, SirTrevor::Helpers::FormBuilder
      end
    end

    config.image_sizes = {
      post: [580, 326],
      thumbnail: [80, 45]
    }
  end

  def self.config(&block)
    @@config ||= SirTrevor::Engine::Configuration.new
    yield @@config if block
    return @@config
  end

end