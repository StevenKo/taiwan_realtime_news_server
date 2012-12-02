require 'sidekiq/web'
TaiwanRealtimeNewsRails::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      
      resources :categories do
        collection do
          get 'all'
        end
      end
      
      resources :news do
        collection do
          get 'promotion'
        end
      end
    end
  end
end
