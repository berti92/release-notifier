Rails.application.routes.draw do
  root to: "notifications#index"
  get '/unsubscribe', to: 'home#block_mail', as: :block_mail
  get '/notifications/:id/duplicate', to: 'notifications#duplicate', as: :duplicate_notification
  resources :notifications
end
