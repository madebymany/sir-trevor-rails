module SirTrevorRails
  class Engine < Rails::Engine

    require 'redcarpet'

    initializer "sir_trevor_rails.load_app_instance_data" do |app|
      SirTrevorRails.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "sir_trevor_rails.helpers" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, SirTrevorRails::Helpers::ViewHelper
      end
    end

    initializer "sir_trevor_rails.view_resolver" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :append_view_path, SirTrevorRails::ViewResolver.new
      end
    end

    initializer "sir_trevor_rails.has_sir_trevor_content" do
      ActiveRecord::Base.send :include, SirTrevorRails::HasSirTrevorContent
    end
  end
end