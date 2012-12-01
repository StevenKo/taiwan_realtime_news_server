require 'sidekiq/web'
TaiwanRealtimeNewsRails::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :categories
      resources :news
    end
  end
end
