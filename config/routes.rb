require 'sidekiq/web'
TaiwanRealtimeNewsRails::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
end
