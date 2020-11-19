Rails.application.routes.draw do
  namespace :blog do
    resources :posts
  end
end
